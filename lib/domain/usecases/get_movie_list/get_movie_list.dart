import 'package:flix_tix/data/repositories/movie_repository.dart';
import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

part 'get_movie_list_params.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParams> {
  final MovieRepository movieRepository;

  GetMovieList({
    required this.movieRepository,
  });

  @override
  Future<Result<List<Movie>>> call(GetMovieListParams params) async {
    var movies = switch (params.type) {
      MovieListType.nowPlaying =>
        await movieRepository.getNowPlayingMovies(page: params.page),
      MovieListType.upcoming =>
        await movieRepository.getUpcomingMovies(page: params.page),
    };

    return switch (movies) {
      Success(value: final movies) => Result.success(movies),
      Error(:final message) => Result.error(message),
    };
  }
}
