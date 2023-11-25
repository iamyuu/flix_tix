import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_tix/presentation/providers/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    final result = await getMovieList(
      GetMovieListParams(
        page: page,
        type: MovieListType.upcoming,
      ),
    );

    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);

      case Error(error: _):
        state = const AsyncData([]);
        break;
    }
  }
}
