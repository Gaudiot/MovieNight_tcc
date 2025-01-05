import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/states/watched_state.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/storage/movie.storage.dart";

class WatchedViewmodel extends BaseViewModel {
  final WatchedStateEntity _state = WatchedStateEntity();

  List<MovieModel> get movies => _state.movies;
  String get queryTitle => _state.queryTitle;
  MovieGenre get queryGenre => _state.queryGenre;
  bool get filterFavorite => _state.filterFavorite;

  void onUpdateQueryTitle({
    required String title,
  }) {
    _state.updateQueryTitle = title;
    getMovies();
  }

  Future<void> onUpdateQueryGenre({required MovieGenre? movieGenre}) async {
    _state.updateQueryGenre = movieGenre ?? MovieGenre.unknown;
    await getMovies();
  }

  Future<void> onToggleFilterFavorite() async {
    _state.toggleFilterFavorite();
    await getMovies();
  }

  Future<void> onMovieRemoved({required String movieId}) async {
    final result = await watchedStorage.delete(movieId: movieId);
    if (result.hasError || !result.data!) return;

    _state.updateMovies =
        _state.movies.where((movie) => movie.id != movieId).toList();
    notifyListeners();
  }

  Future<void> onMovieFavorite({
    required String movieId,
    bool isFavorite = false,
  }) async {
    final result = await watchedStorage.get(movieId: movieId);
    if (!result.hasData) return;

    final movie = result.data!;
    movie.favorite = !isFavorite;

    final saveResult = await watchedStorage.save(movie: movie);
    if (!saveResult.isOk) return;

    _state.updateMovies =
        _state.movies.map((m) => m.id == movieId ? movie : m).toList();
    notifyListeners();
  }

  Future<void> getMovies() async {
    setIsLoading(isLoading: true);

    final result = await watchedStorage.getAll();
    if (result.hasError) return;

    final allMovies = result.data ?? [];

    final filteredMovies = allMovies.where((movie) {
      final isFavorite = !_state.filterFavorite || movie.favorite;
      final includesTitle = _state.queryTitle.isEmpty ||
          movie.title.toLowerCase().contains(_state.queryTitle.toLowerCase());
      final includesGenre = _state.queryGenre == MovieGenre.unknown ||
          movie.genres.map((genre) => genre.id).contains(_state.queryGenre.id);

      return isFavorite && includesGenre && includesTitle;
    }).toList();

    filteredMovies.sort((a, b) => a.runtime.compareTo(b.runtime));

    _state.updateMovies = filteredMovies;

    setIsLoading(isLoading: false);
  }
}
