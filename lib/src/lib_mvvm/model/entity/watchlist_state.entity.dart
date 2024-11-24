import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";

class WatchlistStateEntity {
  List<MovieModel> movies;
  String queryTitle;
  MovieGenre queryGenre;

  WatchlistStateEntity({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
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
}
