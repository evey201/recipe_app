import 'package:dio/dio.dart';
import 'package:recipe_app/constants.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }
    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );
    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      // print(e);
      if (e.response != null) {
        return e.response;
      }
      return null;
    }
  }
}
