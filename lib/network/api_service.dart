import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  
  // Using JSONPlaceholder as sample public API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiService() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    );
  }

  // Fetch posts from external API
  Future<List<dynamic>> fetchData() async {
    try {
      final response = await _dio.get('/posts');
      
      if (response.statusCode == 200) {
        // Return only first 20 items for better performance
        final data = response.data as List;
        return data.take(20).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      } else {
        throw Exception('Failed to fetch data: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Fetch single post by ID
  Future<Map<String, dynamic>> fetchPostById(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Failed to fetch post: $e');
    }
  }

  // Example: Fetch users
  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
