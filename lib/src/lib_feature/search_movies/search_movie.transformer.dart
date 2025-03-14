import "package:movie_night_tcc/src/base/enums/storage_collections.enum.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/movie.entity.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/movie.storage.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/search_movie.entity.dart";

class SearchMovieTransformer {
  static Future<List<SearchMovieEntity>> fromMovieModels(
    List<MovieModel> movies,
  ) async {
    final watchedStorage =
        MovieStorage(movieCollection: StorageCollections.watched);
    final watchlistStorage =
        MovieStorage(movieCollection: StorageCollections.watchlist);

    final watchedMovies = await watchedStorage.getAll();
    final watchlistMovies = await watchlistStorage.getAll();

    if (!watchedMovies.hasData || !watchlistMovies.hasData) {
      return [];
    }

    final watchedMoviesIds =
        watchedMovies.data!.map((movie) => movie.tmdbId).toList();
    final watchlistMoviesIds =
        watchlistMovies.data!.map((movie) => movie.tmdbId).toList();

    return movies
        .map(
          (movie) => SearchMovieEntity(
            movie: movie,
            isWatched: watchedMoviesIds.contains(movie.tmdbId),
            isWatchlist: watchlistMoviesIds.contains(movie.tmdbId),
          ),
        )
        .toList();
  }
}
