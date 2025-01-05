import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/states/watchlist_state.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/storage/movie.storage.dart";

class WatchlistViewmodel extends BaseViewModel {
  final WatchlistStateEntity _state = WatchlistStateEntity();

  List<MovieModel> get movies => _state.movies;
  String get queryTitle => _state.queryTitle;
  MovieGenre get queryGenre => _state.queryGenre;

  void onUpdateQueryTitle({
    required String title,
  }) {
    _state.updateQueryTitle = title;
    getMovies();
  }

  void onUpdateQueryGenre({required MovieGenre? movieGenre}) {
    _state.updateQueryGenre = movieGenre ?? MovieGenre.unknown;
    getMovies();
  }

  Future<void> onMovieWatched({required String movieId}) async {
    final getResult = await watchlistStorage.get(movieId: movieId);
    if (!getResult.hasData) return;

    final movie = getResult.data!;

    final deleteResult = await watchlistStorage.delete(movieId: movieId);
    if (deleteResult.hasError || !deleteResult.data!) return;

    final saveResult = await watchedStorage.save(movie: movie);
    if (saveResult.hasError || !saveResult.data!) return;

    _state.updateMovies = _state.movies.where((m) => m.id != movieId).toList();
    notifyListeners();
  }

  Future<void> onMovieRemoved({required String movieId}) async {
    final result = await watchlistStorage.delete(movieId: movieId);
    if (result.hasError || !result.data!) return;

    _state.updateMovies =
        _state.movies.where((movie) => movie.id != movieId).toList();
    notifyListeners();
  }

  Future<void> getMovies() async {
    setIsLoading(isLoading: true);

    final result = await watchlistStorage.getAll();

    final allMovies = result.data ?? [];

    final filteredMovies = allMovies.where((movie) {
      final includesGenre = _state.queryGenre == MovieGenre.unknown ||
          movie.genres.map((genre) => genre.id).contains(_state.queryGenre.id);
      final includesTitle = _state.queryTitle.isEmpty ||
          movie.title.toLowerCase().contains(_state.queryTitle.toLowerCase());

      return includesGenre && includesTitle;
    }).toList();

    filteredMovies.sort((a, b) => a.runtime.compareTo(b.runtime));

    _state.updateMovies = filteredMovies;

    setIsLoading(isLoading: false);
  }
}
