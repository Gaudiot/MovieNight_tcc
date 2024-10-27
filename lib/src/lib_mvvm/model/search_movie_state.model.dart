import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/search_movie.model.dart";

class SearchMovieStateModel {
  List<SearchMovieModel> movies;
  String queryTitle;
  MovieGenre queryGenre;
  int currentPage;

  SearchMovieStateModel({
    this.movies = const [],
    this.queryTitle = "",
    this.queryGenre = MovieGenre.unknown,
    this.currentPage = 1,
  });

  SearchMovieStateModel copyWith({
    List<SearchMovieModel>? movies,
    String? queryTitle,
    MovieGenre? queryGenre,
    int? currentPage,
  }) {
    return SearchMovieStateModel(
      movies: movies ?? this.movies,
      queryTitle: queryTitle ?? this.queryTitle,
      queryGenre: queryGenre ?? this.queryGenre,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  void clearMovies() {
    currentPage = 1;
    movies.clear();
  }

  void addMovies(List<SearchMovieModel> newMovies) {
    movies = List.from(movies)..addAll(newMovies);
  }

  set updateMovies(List<SearchMovieModel> newMovies) {
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
