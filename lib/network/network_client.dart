import 'package:dio/dio.dart';
import 'package:mad_final_project/errors/exceptions.dart';
import 'package:mad_final_project/utils/network_constants.dart';

class NetworkClient {
  Dio _dio = Dio();

  NetworkClient({String? baseURL}) {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: Duration(milliseconds: 20000),
      connectTimeout: Duration(milliseconds: 20000),
      baseUrl: baseURL ?? NetworkConstants.baseUrlDev,
      contentType: "application/json",
    );

    _dio = Dio(baseOptions);

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    String? token,
  }) async {
    Response response;

    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});

      response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(headers: map),
      );

      return response;
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
  }

  Future<Response> post(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    Response response;

    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});
      response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: map,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );

      return response;
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
  }

  Future<Response> put(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    Response response;

    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});
      response = await _dio.put(
        url,
        data: body,
        options: Options(
          headers: map,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );

      return response;
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
  }

  Future<Response> delete(String url, {String? token}) async {
    Response response;

    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});
      response = await _dio.delete(url, options: Options(headers: map));

      return response;
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
  }
}
