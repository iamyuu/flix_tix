import 'package:flix_tix/data/repositories/movie_repository.dart';
import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

part 'get_movie_detail_params.dart';

class GetMovieDetail implements UseCase<Result<Movie>, GetMovieDetailParams> {
  final MovieRepository movieRepository;

  GetMovieDetail({
    required this.movieRepository,
  });

  @override
  Future<Result<Movie>> call(GetMovieDetailParams params) async {
    var movie = await movieRepository.getMovieDetail(id: params.movie.id);

    return switch (movie) {
      Success(value: final data) => Result.success(data),
      Error(:final message) => Result.error(message),
    };
  }
}
