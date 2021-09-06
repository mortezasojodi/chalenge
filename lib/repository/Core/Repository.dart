import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:dio/dio.dart';

Future<Response?> MsaPost(u,
    {Map<String, dynamic>? p, Object? body, header}) async {
  var dio = Dio();
  var response = await dio.post(serverUrlDio + u,
      data: body, options: Options(headers: header));
  return response;
}

Future<Response?> MsaGet(u,
    {Map<String, dynamic>? p, Object? body, header}) async {
  var dio = Dio();
  var response = await dio.get(serverUrlDio + u,
      queryParameters: p, options: Options(headers: header));
  return response;
}
