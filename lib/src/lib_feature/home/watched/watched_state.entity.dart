import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_feature/home/movie.entity.dart";

class WatchedStateEntity {
  List<MovieModel> movies;
  String queryTitle;
  MovieGenre queryGenre;
  bool filterFavorite;

  WatchedStateEntity({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
    this.filterFavorite = false,
  });

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
