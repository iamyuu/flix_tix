import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TmbdbClient {
  Dio init() {
    Dio dio = Dio();

    const String accessToken = String.fromEnvironment("TMDB_API_ACCESS_TOKEN");

    dio.options.baseUrl = 'https://api.themoviedb.org/3';
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
      ),
    ));

    return dio;
  }
}
