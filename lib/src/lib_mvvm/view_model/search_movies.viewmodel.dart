import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.api.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/search_movie.model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/search_movie.transformer.dart";

class SearchMoviesViewmodel extends BaseViewModel {
  final _movieNetwork = MovieApi();
  final _localStorage = locator.get<ILocalStorage>();

  List<SearchMovieModel> movies = [];
  int _currentPage = 1;
  String queryTitle = "";
  MovieGenre queryGenre = MovieGenre.unknown;

  void onUpdateMovieGenre({required MovieGenre? movieGenre}) {
    queryGenre = movieGenre ?? MovieGenre.unknown;
    _currentPage = 1;
    movies.clear();
    fetchMovies();
  }

  Future<void> updateQueryTitle({
    required String title,
  }) async {
    queryTitle = title;
    _currentPage = 1;
    movies.clear();
    fetchMovies();
  }

  Future<void> onMovieWatchlist({
    required String movieId,
  }) async {
    final movieIndex = movies.indexWhere((movie) => movie.movie.id == movieId);
    if (movieIndex == -1) return;

    final isSaved = await _localStorage.save<MovieModel>(
      collection: LocalStorageCollectionEnum.watchlist.name,
      key: movieId,
      value: movies[movieIndex].movie,
    );
    if (isSaved.hasError || isSaved.data == false) return;

    movies[movieIndex].isWatchlist = true;
    notifyListeners();
  }

  Future<void> onMovieWatched({
    required String movieId,
  }) async {
    final movieIndex = movies.indexWhere((movie) => movie.movie.id == movieId);
    if (movieIndex == -1) return;

    final isDeleted = await _localStorage.delete(
      collection: LocalStorageCollectionEnum.watchlist.name,
      key: movieId,
    );
    if (!isDeleted) return;

    final isSaved = await _localStorage.save<MovieModel>(
      collection: LocalStorageCollectionEnum.watched.name,
      key: movieId,
      value: movies[movieIndex].movie,
    );
    if (isSaved.hasError || isSaved.data == false) return;

    movies[movieIndex].isWatchlist = false;
    movies[movieIndex].isWatched = true;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    setIsLoading(isLoading: true);

    final List<int> movieIds;
    final List<MovieModel> movieModels = [];

    if (queryTitle.isEmpty) {
      final trendingMovies = await _movieNetwork.getTrendingMovies(
        request: GetTrendingMoviesRequest(page: _currentPage),
      );
      if (trendingMovies.hasError) return;

      movieIds = trendingMovies.data!.ids;
    } else {
      final searchMovies = await _movieNetwork.getMoviesByTitle(
        request: GetMoviesByTitleRequest(
          title: queryTitle,
          page: _currentPage,
        ),
      );
      if (searchMovies.hasError) return;

      movieIds = searchMovies.data!.ids;
    }

    final moviesDetails = await Future.wait(
      movieIds
          .map(
            (movieId) => _movieNetwork.getMovieDetails(
              request: GetMovieDetailsRequest(id: movieId),
            ),
          )
          .toList(),
    );

    for (final movieDetails in moviesDetails) {
      if (movieDetails.hasError) continue;

      final movie = movieDetails.data!.toMovieModel();
      movieModels.add(movie);
    }
    final moviesToAdd =
        await SearchMovieTransformer.fromMovieModels(movieModels);
    movies.addAll(
      moviesToAdd.where(
        (movieToAdd) {
          final includesGenre = queryGenre == MovieGenre.unknown ||
              movieToAdd.movie.genres
                  .map((genre) => genre.id)
                  .contains(queryGenre.id);

          return includesGenre;
        },
      ),
    );

    _currentPage++;
    setIsLoading(isLoading: false);
  }
}
