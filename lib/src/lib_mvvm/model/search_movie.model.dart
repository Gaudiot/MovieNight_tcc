import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";

class SearchMovieModel {
  MovieModel movie;
  bool isWatchlist;
  bool isWatched;

  SearchMovieModel({
    required this.movie,
    this.isWatchlist = false,
    this.isWatched = false,
  });
}
