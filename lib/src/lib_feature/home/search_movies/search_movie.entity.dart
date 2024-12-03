import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";

class SearchMovieEntity {
  final MovieModel movie;
  bool isWatchlist;
  bool isWatched;

  SearchMovieEntity({
    required this.movie,
    this.isWatchlist = false,
    this.isWatched = false,
  });
}
