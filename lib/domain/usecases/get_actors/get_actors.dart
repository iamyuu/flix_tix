import 'package:flix_tix/data/repositories/movie_repository.dart';
import 'package:flix_tix/domain/entities/actor.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

part 'get_actors_params.dart';

class GetMovieDetail implements UseCase<Result<List<Actor>>, GetActorsParams> {
  final MovieRepository movieRepository;

  GetMovieDetail({
    required this.movieRepository,
  });

  @override
  Future<Result<List<Actor>>> call(GetActorsParams params) async {
    var movie = await movieRepository.getActors(id: params.movieId);

    return switch (movie) {
      Success(value: final actors) => Result.success(actors),
      Error(:final message) => Result.error(message),
    };
  }
}
