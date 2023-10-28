import 'package:flix_tix/domain/entities/actor.dart';
import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlayingMovies({
    int page = 1,
  });

  Future<Result<List<Movie>>> getUpcomingMovies({
    int page = 1,
  });

  Future<Result<Movie>> getMovieDetail({
    required int id,
  });

  Future<Result<List<Actor>>> getActors({
    required int id,
  });
}
