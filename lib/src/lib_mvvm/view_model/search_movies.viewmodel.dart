import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/search_movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/search_movie_state.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.api.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/storage/movie.storage.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/transformer/search_movie.transformer.dart";

class SearchMoviesViewmodel extends BaseViewModel {
  final _movieNetwork = MovieApi();

  final SearchMovieStateEntity _state = SearchMovieStateEntity();

  List<SearchMovieEntity> get movies => _state.movies;
  String get queryTitle => _state.queryTitle;
  MovieGenre get queryGenre => _state.queryGenre;
  int get currentPage => _state.currentPage;

  void onUpdateQueryGenre({required MovieGenre? movieGenre}) {
    _state.updateQueryGenre = movieGenre ?? MovieGenre.unknown;
    _state.clearMovies();
    fetchMovies();
  }

  Future<void> onUpdateQueryTitle({
    required String title,
  }) async {
    _state.updateQueryTitle = title;
    _state.clearMovies();
    fetchMovies();
  }

  Future<void> onMovieWatchlist({
    required String movieId,
  }) async {
    final movieIndex =
        _state.movies.indexWhere((movie) => movie.movie.id == movieId);
    if (movieIndex == -1) return;

    final isSaved = await watchlistStorage.save(
      movie: _state.movies[movieIndex].movie,
    );
    if (isSaved.hasError || isSaved.data == false) return;

    _state.movies[movieIndex].isWatchlist = true;
    notifyListeners();
  }

  Future<void> onMovieWatched({
    required String movieId,
  }) async {
    final movieIndex =
        _state.movies.indexWhere((movie) => movie.movie.id == movieId);
    if (movieIndex == -1) return;

    final isDeleted = await watchlistStorage.delete(
      movieId: movieId,
    );
    if (isDeleted.hasError || isDeleted.data == false) return;

    final isSaved = await watchedStorage.save(
      movie: _state.movies[movieIndex].movie,
    );
    if (isSaved.hasError || isSaved.data == false) return;

    _state.movies[movieIndex].isWatchlist = false;
    _state.movies[movieIndex].isWatched = true;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    if (isLoading) return;
    setIsLoading(isLoading: true);

    final List<int> movieIds;
    final List<MovieModel> movieModels = [];

    if (_state.queryTitle.isEmpty) {
      final trendingMovies = await _movieNetwork.getTrendingMovies(
        request: GetTrendingMoviesRequest(page: _state.currentPage),
      );
      if (trendingMovies.hasError) {
        setIsLoading(isLoading: false);
        return;
      }

      movieIds = trendingMovies.data!.ids;
    } else {
      final searchMovies = await _movieNetwork.getMoviesByTitle(
        request: GetMoviesByTitleRequest(
          title: _state.queryTitle,
          page: _state.currentPage,
        ),
      );
      if (searchMovies.hasError) {
        setIsLoading(isLoading: false);
        return;
      }

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
    final filteredMovies = moviesToAdd.where(
      (movieToAdd) {
        final includesGenre = _state.queryGenre == MovieGenre.unknown ||
            movieToAdd.movie.genres
                .map((genre) => genre.id)
                .contains(_state.queryGenre.id);

        return includesGenre;
      },
    ).toList();

    _state.addMovies(filteredMovies);
    _state.updateCurrentPage = _state.currentPage + 1;
    setIsLoading(isLoading: false);
  }
}
