import 'package:flix_tix/domain/entities/movie.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:flix_tix/presentation/providers/usecase/get_movie_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<Movie?> movieDetail(MovieDetailRef ref, {required Movie movie}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  var movieDetailResult =
      await getMovieDetail(GetMovieDetailParams(movie: movie));

  return switch (movieDetailResult) {
    Success(value: final movieDetail) => movieDetail,
    Error(message: _) => null
  };
}
