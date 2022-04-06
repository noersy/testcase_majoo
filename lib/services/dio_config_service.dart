import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance;

createInstance() async {
  var options = BaseOptions(
    baseUrl: "https://api.themoviedb.org/3/trending/all/day",
    connectTimeout: 12000,
    receiveTimeout: 12000,
    queryParameters: {"api_key": "0bc9e6490f0a9aa230bd01e268411e10"},
  );
  dioInstance = new Dio(options);
  dioInstance.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
}

Future<Dio> dio() async {
  await createInstance();
  dioInstance.options.baseUrl = "https://api.themoviedb.org/3/trending/all/day";
  return dioInstance;
}
