import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../flavor_config.dart';

class HTTPService {
  final Dio dio = Dio();

  String? baseUrl;
  late String _baseUrl;

  HTTPService([this.baseUrl]) {
    _baseUrl = baseUrl ?? FlavorConfig.instance!.values!.baseUrl!;

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // Do something before request is sent
      /* var preResponse = {
        'uri': options.uri.toString(),
        'headers': options.headers.toString(),
        'data': options.data.toString(),
        'timestamp': DateTime.now().toString()
      }; */

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioException` object eg: `handler.reject(DioException)`
    }, onResponse: (response, handler) {
      //print(response);
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioException` object eg: `handler.reject(DioException)`
    }, onError: (DioException e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? data, headers}) async {
    try {
      String url = '$_baseUrl$path';

      Map<String, dynamic> qData = {};
      if (data != null) {
        qData.addAll(data);
      }
      return await dio.get(url,
          queryParameters: qData,
          options: Options(
              headers: await _setHeaders(headers: headers),
              followRedirects: false,
              receiveTimeout: const Duration(seconds: 10),
              validateStatus: (status) {
                return status! < 500 && status != 404;
              }));
    } on DioException catch (e) {
      log('Unable to perform get request.');
      log('DioException:$e');
      log(e.response.toString());

      throw Exception(e.response!.statusMessage);
    } on SocketException catch (e) {
      log('No internet connection');
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> qData = {};
      if (data != null) {
        qData.addAll(data);
      }

      return await dio.post(url,
          data: jsonEncode(qData),
          options: Options(
              headers: await _setHeaders(),
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
    } on DioException catch (e) {
      log('Unable to perform post request: ${e.error}');
      log('DioException: ${e.response}');

      throw Exception(e.response!.data);
    } on SocketException catch (e) {
      log('No internet connection');
      throw Exception(e.message);
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> qData = {};
      if (data != null) {
        qData.addAll(data);
      }

      return await dio.put(url,
          data: jsonEncode(qData),
          options: Options(
              headers: await _setHeaders(),
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
    } on DioException catch (e) {
      log('Unable to perform post request: ${e.error}');
      log('DioException: ${e.response}');

      throw Exception(e.response!.data);
    } on SocketException catch (e) {
      log('No internet connection');
      throw Exception(e.message);
    }
  }

  Future<Response> upload(String path, {Map<String, dynamic>? data}) async {
    try {
      String url = '$_baseUrl$path';

      Map<String, dynamic> qData = {};
      if (data != null) {
        qData.addAll(data);
      }
      qData['avatar'] = await MultipartFile.fromFile(data!["avatar"]);

      final formData = FormData.fromMap(qData);

      return await dio.post(url,
          data: formData,
          options: Options(
              headers: await _setHeaders(),
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
    } on DioException catch (e) {
      log('Unable to perform post request: ${e.error}');
      log('DioException: ${e.response}');

      throw Exception(e.response!.data);
    } on SocketException catch (e) {
      log('No internet connection');
      throw Exception(e.message);
    }
  }

  Future<Response?> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> qData = {};
      if (data != null) {
        qData.addAll(data);
      }

      return await dio.delete(url,
          data: jsonEncode(data),
          options: Options(
            headers: await _setHeaders(),
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ));
    } on DioException catch (e) {
      log('Unable to perform post request: ${e.error}');
      log('DioException: ${e.response}');

      throw e.response!.data;
    } on SocketException {
      log('No internet connection');
    }
    return null;
  }

  _setHeaders({headers}) async {
    Map<String, dynamic> storageHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    return storageHeaders;
  }
}
