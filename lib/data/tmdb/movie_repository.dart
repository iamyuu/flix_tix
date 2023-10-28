import 'package:dio/dio.dart';
import 'package:flix_tix/data/tmdb/client.dart';
import 'package:flix_tix/data/repositories/movie_repository.dart';
import 'package:flix_tix/domain/entities/actor.dart';
import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';

enum _MovieType {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _value;

  const _MovieType(String value) : _value = value;

  @override
  String toString() => _value;
}

class TmbdbMovieRepository implements MovieRepository {
  final Dio dio;

  TmbdbMovieRepository({
    Dio? dio,
  }) : dio = dio ?? TmbdbClient().init();

  Future<Result<List<Movie>>> _getMovie({
    required _MovieType movieType,
    int page = 1,
  }) async {
    try {
      final Response response = await dio.get(
        '/movie/${movieType.toString()}',
        queryParameters: {
          'page': page,
        },
      );

      final movies = List<Map<String, dynamic>>.from(response.data['results'])
          .map((e) => Movie.fromJSON(e))
          .toList();

      return Result.success(movies);
    } on DioException catch (e) {
      return Result.error('${e.message}');
    }
  }

  @override
  Future<Result<List<Actor>>> getActors({
    required int id,
  }) async {
    try {
      final Response response = await dio.get(
        '/movie/$id/credits',
      );

      final actors = List<Map<String, dynamic>>.from(response.data['cast'])
          .map((e) => Actor.fromJSON(e))
          .toList();

      return Result.success(actors);
    } on DioException catch (e) {
      return Result.error('${e.message}');
    }
  }

  @override
  Future<Result<Movie>> getMovieDetail({
    required int id,
  }) async {
    try {
      final Response response = await dio.get(
        '/movie/$id',
      );

      final movie = Movie.fromJSON(response.data);

      return Result.success(movie);
    } on DioException catch (e) {
      return Result.error('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlayingMovies({
    int page = 1,
  }) =>
      _getMovie(movieType: _MovieType.nowPlaying, page: page);

  @override
  Future<Result<List<Movie>>> getUpcomingMovies({
    int page = 1,
  }) =>
      _getMovie(movieType: _MovieType.upcoming, page: page);
}
