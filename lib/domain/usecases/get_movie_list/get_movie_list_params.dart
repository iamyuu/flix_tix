part of 'get_movie_list.dart';

/// avoid to depend to the data layer
enum MovieListType {
  upcoming,
  nowPlaying,
}

class GetMovieListParams {
  final int page;
  final MovieListType type;

  GetMovieListParams({
    this.page = 1,
    required this.type,
  });
}
