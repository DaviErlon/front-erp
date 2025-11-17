import 'package:dio/dio.dart';

Dio getDio(){
  return Dio(
    BaseOptions(
      baseUrl: 'server',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  ); 
}