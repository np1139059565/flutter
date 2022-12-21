import 'package:dio/dio.dart';

import '../utils/my_log_utils.dart';

class MyServiceUtils {
  static final Dio dio = Dio();
  // final HttpClient hc = HttpClient();
  static final _SCHEME = "http";
  static final _HOST = "192.168.1.32";
  static final _PORT = 8888;

  static final allJobListUri = '/job/list';
  static final orderJobListUri = '/job/order_list';
  static final orderCountUri = '/job/order_list';
  static final sessionUri = '/user/session';
  static final loginUri = '/user/login';

  static String parentUrl = "$_SCHEME://$_HOST:$_PORT";

  static void getAsync(String path, Function callback,
      {Map<String, dynamic>? queryParameters}) async {
    dynamic err;
    dynamic respBody;
    try {
      // Uri uri = Uri(scheme: _SCHEME, host: _HOST, port: _PORT, path: path,queryParameters: data);
      // HttpClientRequest req = await hc.getUrl(uri);
      // req.headers.add("user-agent", "test");
      // HttpClientResponse resp = await req.close();
      // respBody = await resp.transform(utf8.decoder).join();
      final resp = await dio.get(path = "$parentUrl/$path",
          queryParameters: queryParameters);
      respBody = resp.data;
    } catch (e) {
      MyLogUtils.err(e);
      err = e;
    } finally {
      // hc.close();
      callback(err, respBody);
    }
  }

  static dynamic get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    dynamic err;
    dynamic respBody;
    try {
      // Uri uri = Uri(scheme: _SCHEME, host: _HOST, port: _PORT, path: path,queryParameters: data);
      // HttpClientRequest req = await hc.getUrl(uri);
      // req.headers.add("user-agent", "test");
      // HttpClientResponse resp = await req.close();
      // respBody = await resp.transform(utf8.decoder).join();
      final resp = await dio.get(path = "$parentUrl/$path",
          queryParameters: queryParameters);
      respBody = resp.data;
    } catch (e) {
      MyLogUtils.err(e);
      err = e;
    }
    return {'e': err, 'body': respBody};
  }

  static void postAsync(String path, Function callback,
      {dynamic? data, Map<String, dynamic>? queryParameters}) async {
    dynamic err;
    String? respBody;
    try {
      final resp = await dio.post(path = "$parentUrl/$path",
          data: data, queryParameters: queryParameters);
      respBody = resp.data;
    } catch (e) {
      err = e;
      callback(err, respBody);
    }
  }

  static void getJobListAsync(callback,
      {int page = 1, int pageSize = 1, String search = ""}) {
    return getAsync(
      allJobListUri,
      callback,
      queryParameters: {
        "page": page.toString(),
        "page_size": pageSize.toString(),
        "search": search
      },
    );
  }
}
