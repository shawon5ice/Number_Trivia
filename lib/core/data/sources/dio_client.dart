import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../logger/logger.dart';
import '../../utils/message.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);


  Future<Response?> post({
    required String path,
    dynamic request,
    required Function(dynamic, String?) responseCallback,
    required Function(String?, int?) failureCallback,
    dynamic header,
  }) async {
    Response? response;
    var connectivityResult = await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        response = await dio.post(path,
          data: request,
          options: Options(
            headers: header,
            contentType: Headers.formUrlEncodedContentType,
            receiveTimeout: 3000,
          ),
        );
        if (response.data != null && response.statusCode == HttpStatus.ok) {
          responseCallback(response.data, response.statusMessage);
        } else {
          failureCallback(response.statusMessage, response.statusCode);
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        failureCallback(noInternetConnectionMessage, 12029);
      }
    } on Exception catch (e, _) {
      logger.printErrorLog("Response code: ${response?.statusCode}");
      logger.printErrorLog(e);
      failureCallback(tryAgainErrorMessage, 400);
    }
    return response;
  }
}