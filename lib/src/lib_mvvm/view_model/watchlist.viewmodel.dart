import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/watched.storage.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/watchlist.storage.dart";

class WatchlistViewmodel extends BaseViewModel {
  final WatchlistStorage _watchlistStorage = WatchlistStorage();
  final WatchedStorage _watchedStorage = WatchedStorage();

  final List<MovieModel> movies = [];
  String queryTitle = "";
  MovieGenre queryGenre = MovieGenre.unknown;

  void onUpdateQueryTitle({
    required String title,
  }) {
    queryTitle = title;
    getMovies();
  }

  void onUpdateQueryGenre({required MovieGenre? movieGenre}) {
    queryGenre = movieGenre ?? MovieGenre.unknown;
    getMovies();
  }

  Future<void> onMovieWatched({required String movieId}) async {
    final getResult = await _watchlistStorage.get(movieId: movieId);
    if (!getResult.hasData) return;

    final movie = getResult.data!;

    final deleteResult = await _watchlistStorage.delete(movieId: movieId);
    if (deleteResult.hasError || !deleteResult.data!) return;

    final saveResult = await _watchedStorage.save(movie: movie);
    if (saveResult.hasError || !saveResult.data!) return;

    final movieIndex = movies.indexWhere((m) => m.id == movieId);
    if (movieIndex == -1) return;

    movies.removeAt(movieIndex);
    notifyListeners();
  }

  Future<void> onMovieRemoved({required String movieId}) async {
    final result = await _watchlistStorage.delete(movieId: movieId);
    if (result.hasError || !result.data!) return;

    final movieIndex = movies.indexWhere((movie) => movie.id == movieId);
    if (movieIndex == -1) return;

    movies.removeAt(movieIndex);
    notifyListeners();
  }

  Future<void> getMovies() async {
    setIsLoading(isLoading: true);

    movies.clear();
    final result = await _watchlistStorage.getAll();

    final allMovies = result.data ?? [];

    movies.addAll(
      allMovies.where((movie) {
        final includesGenre = queryGenre == MovieGenre.unknown ||
            movie.genres.map((genre) => genre.id).contains(queryGenre.id);
        final includesTitle = queryTitle.isEmpty ||
            movie.title.toLowerCase().contains(queryTitle.toLowerCase());

        return includesGenre && includesTitle;
      }),
    );

    movies.sort((a, b) => b.rating.compareTo(a.rating));

    setIsLoading(isLoading: false);
  }
}
