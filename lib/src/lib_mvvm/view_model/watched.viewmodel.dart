import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/watched.storage.dart";

class WatchedViewmodel extends BaseViewModel {
  final WatchedStorage _watchedStorage = WatchedStorage();

  final List<MovieModel> movies = [];
  String queryTitle = "";
  MovieGenre queryGenre = MovieGenre.unknown;
  bool filterFavorite = false;

  void onUpdateQueryTitle({
    required String title,
  }) {
    queryTitle = title;
    getMovies();
  }

  Future<void> onUpdateQueryGenre({required MovieGenre? movieGenre}) async {
    queryGenre = movieGenre ?? MovieGenre.unknown;
    await getMovies();
  }

  Future<void> onToggleFilterFavorite() async {
    filterFavorite = !filterFavorite;
    await getMovies();
  }

  Future<void> onMovieRemoved({required String movieId}) async {
    final result = await _watchedStorage.delete(movieId: movieId);
    if (result.hasError) return;
    if (!result.data!) return;

    final movieIndex = movies.indexWhere((movie) => movie.id == movieId);
    if (movieIndex == -1) return;

    movies.removeAt(movieIndex);
    notifyListeners();
  }

  Future<void> onMovieFavorite({
    required String movieId,
    bool isFavorite = false,
  }) async {
    final result = await _watchedStorage.get(movieId: movieId);
    if (!result.hasData) return;

    final movie = result.data!;
    movie.favorite = !isFavorite;

    final saveResult = await _watchedStorage.save(movie: movie);
    if (!saveResult.isOk) return;

    final movieIndex = movies.indexWhere((m) => m.id == movieId);
    if (movieIndex == -1) return;

    movies[movieIndex].favorite = !isFavorite;
    notifyListeners();
  }

  Future<void> getMovies() async {
    setIsLoading(isLoading: true);

    await Future.delayed(const Duration(seconds: 2));

    movies.clear();
    final result = await _watchedStorage.getAll();
    if (!result.hasData) return;

    final allMovies = result.data ?? [];

    movies.addAll(
      allMovies.where((movie) {
        final isFavorite = !filterFavorite || movie.favorite;
        final includesTitle = queryTitle.isEmpty ||
            movie.title.toLowerCase().contains(queryTitle.toLowerCase());
        final includesGenre = queryGenre == MovieGenre.unknown ||
            movie.genres.map((genre) => genre.id).contains(queryGenre.id);

        return isFavorite && includesGenre && includesTitle;
      }),
    );

    movies.sort((a, b) => b.rating.compareTo(a.rating));

    setIsLoading(isLoading: false);
  }
}
