import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;
  static const String baseUrl = 'http://72.61.229.146:8080';

  AuthService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ));

  /// Login user with API
  /// Returns success status and message
  /// For testing: user@example.com / password123 works locally
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // Check for local testing account first
    if (email == 'user@example.com' && password == 'password123') {
      await _saveToken('test-token-local', 'Bearer');
      return {
        'success': true,
        'message': 'Login successful (Local)',
        'isLocal': true,
      };
    }

    // Try real API
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Save token to SharedPreferences
        if (data['token'] != null) {
          await _saveToken(data['token'], data['tokenType'] ?? 'Bearer');
        }

        return {
          'success': true,
          'message': 'Login successful',
          'data': data,
          'isLocal': false,
        };
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      return _handleError(e, 'Invalid email or password');
    } catch (e) {
      return {
        'success': false,
        'message': 'Login error: $e',
      };
    }
  }

  /// Signup user with API
  /// Accepts email and password only (per API spec)
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/signup',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Account created successfully',
          'data': response.data,
        };
      } else {
        throw Exception('Signup failed');
      }
    } on DioException catch (e) {
      return _handleError(e, 'Signup failed');
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/reset-password-request',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Password reset email sent',
          'data': response.data,
        };
      } else {
        throw Exception('Password reset request failed');
      }
    } on DioException catch (e) {
      return _handleError(e, 'Password reset request failed');
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }
  }

  /// Reset password with token
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/reset-password',
        data: {
          'token': token,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Password reset successfully',
          'data': response.data,
        };
      } else {
        throw Exception('Password reset failed');
      }
    } on DioException catch (e) {
      return _handleError(e, 'Password reset failed');
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }
  }

  /// Check API health
  Future<Map<String, dynamic>> checkHealth() async {
    try {
      final response = await _dio.get('/api/health');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        throw Exception('Health check failed');
      }
    } on DioException catch (e) {
      return _handleError(e, 'Health check failed');
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }
  }

  /// Save JWT token to SharedPreferences
  Future<void> _saveToken(String token, String tokenType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('token_type', tokenType);
  }

  /// Get saved JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Get token type
  Future<String?> getTokenType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_type');
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Logout user (clear token)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('token_type');
  }

  /// Handle Dio errors with user-friendly messages
  Map<String, dynamic> _handleError(DioException e, String defaultMessage) {
    String errorMessage = defaultMessage;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Connection timeout. Please check your internet connection.';
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage = 'No internet connection. Please check your network.';
    } else if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final responseData = e.response!.data;

      if (statusCode == 400) {
        errorMessage = 'Invalid request. Please check your input.';
      } else if (statusCode == 401) {
        errorMessage = 'Invalid email or password.';
      } else if (statusCode == 403) {
        errorMessage = 'Access denied.';
      } else if (statusCode == 404) {
        errorMessage = 'Endpoint not found.';
      } else if (statusCode == 409) {
        errorMessage = 'Email already registered.';
      } else if (statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      }

      // Try to extract message from response
      if (responseData is Map && responseData['message'] != null) {
        errorMessage = responseData['message'];
      } else if (responseData is Map && responseData['error'] != null) {
        errorMessage = responseData['error'];
      }
    }

    return {
      'success': false,
      'message': errorMessage,
    };
  }
}
