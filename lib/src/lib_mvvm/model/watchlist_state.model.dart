import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";

class WatchlistStateModel {
  List<MovieModel> movies;
  String queryTitle;
  MovieGenre queryGenre;

  WatchlistStateModel({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
  });

  WatchlistStateModel copyWith({
    List<MovieModel>? movies,
    String? queryTitle,
    MovieGenre? queryGenre,
  }) {
    return WatchlistStateModel(
      movies: movies ?? this.movies,
      queryTitle: queryTitle ?? this.queryTitle,
      queryGenre: queryGenre ?? this.queryGenre,
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
}
