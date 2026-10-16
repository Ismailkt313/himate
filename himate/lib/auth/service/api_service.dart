import 'package:dio/dio.dart';
import 'package:himate/auth/service/auth_service.dart';
import 'package:himate/config/api_config.dart';
import '../../utils/storage.dart';

class ApiService {
  static String get baseUrl => ApiConfig.baseUrl;
  late final Dio dio;

  ApiService._internal(this.dio);

  factory ApiService() {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await Storage.getAccessToken();
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onError: (err, handler) async {
        if (err.response?.statusCode == 401) {
// try refresh
          final refreshed = await AuthService.tryRefresh();
          if (refreshed) {
            final token = await Storage.getAccessToken();
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer $token';
            try {
              final cloneResp = await dio.fetch(opts);
              return handler.resolve(cloneResp);
            } on DioException catch (e) {
              return handler.next(e);
            }
          }
        }
        handler.next(err);
      },
    ));

    return ApiService._internal(dio);
  }

// Generic methods
  Future<Response> get(String path, {Map<String, dynamic>? query, required Map<String, String> headers}) async {
    return dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return dio.post(path, data: data);
  }
}
