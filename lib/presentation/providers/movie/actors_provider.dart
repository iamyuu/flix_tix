import 'package:flix_tix/domain/entities/actor.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/get_actors/get_actors.dart';
import 'package:flix_tix/presentation/providers/usecase/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorsResult = await getActors(GetActorsParams(movieId: movieId));

  return switch (actorsResult) {
    Success(value: final actors) => actors,
    Error(message: _) => const []
  };
}
