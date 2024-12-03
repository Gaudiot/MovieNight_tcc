import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/search_movie.entity.dart";

class SearchMovieStateEntity {
  List<SearchMovieEntity> movies;
  String queryTitle;
  MovieGenre queryGenre;
  int currentPage;

  SearchMovieStateEntity({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
    this.currentPage = 1,
  });

  void clearMovies() {
    currentPage = 1;
    movies.clear();
  }

  void addMovies(List<SearchMovieEntity> newMovies) {
    movies = List.from(movies)..addAll(newMovies);
  }

  set updateMovies(List<SearchMovieEntity> newMovies) {
    movies = newMovies;
  }

  set updateQueryTitle(String newQueryTitle) {
    queryTitle = newQueryTitle;
  }

  set updateQueryGenre(MovieGenre newQueryGenre) {
    queryGenre = newQueryGenre;
  }

  set updateCurrentPage(int newCurrentPage) {
    currentPage = newCurrentPage;
  }
}
