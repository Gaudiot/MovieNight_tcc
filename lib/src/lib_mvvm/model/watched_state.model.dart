import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";

class WatchedStateModel {
  List<MovieModel> movies;
  String queryTitle;
  MovieGenre queryGenre;
  bool filterFavorite;

  WatchedStateModel({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
    this.filterFavorite = false,
  });

  WatchedStateModel copyWith({
    List<MovieModel>? movies,
    String? queryTitle,
    MovieGenre? queryGenre,
    bool? filterFavorite,
  }) {
    return WatchedStateModel(
      movies: movies ?? this.movies,
      queryTitle: queryTitle ?? this.queryTitle,
      queryGenre: queryGenre ?? this.queryGenre,
      filterFavorite: filterFavorite ?? this.filterFavorite,
    );
  }

  void addMovies(List<MovieModel> newMovies) {
    movies.addAll(newMovies);
  }

  set updateMovies(List<MovieModel> newMovies) {
    movies = newMovies;
  }

  set updateQueryTitle(String newQueryTitle) {
    queryTitle = newQueryTitle;
  }

  set updateQueryGenre(MovieGenre newQueryGenre) {
    queryGenre = newQueryGenre;
  }

  void toggleFilterFavorite() {
    filterFavorite = !filterFavorite;
  }
}
