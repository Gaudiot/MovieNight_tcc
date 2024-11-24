import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/main_genre_watched.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/profile_state.entity.dart";

class ProfileTransformer {
  ProfileTransformer._();

  static List<MainGenreWatched> watchedMoviesToTopGenres(
    List<MovieModel> watchedMovies,
  ) {
    final genreCount = <MovieGenre, int>{};
    for (final movie in watchedMovies) {
      for (final genre in movie.genres) {
        genreCount[genre] = (genreCount[genre] ?? 0) + 1;
      }
    }

    // Obter os 5 principais gêneros, excluindo os que têm valor 0
    final topGenresMap = genreCount.entries
        .where(
          (entry) => entry.value > 0,
        )
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topGenres = topGenresMap.take(5).map((entry) {
      return MainGenreWatched(
        genre: entry.key,
        quantity: entry.value,
      );
    }).toList();

    return topGenres;
  }

  static ProfileStateEntity watchedMoviesToProfileState(
    List<MovieModel> watchedMovies,
  ) {
    final totalMinutesWatched = watchedMovies.fold(
      0,
      (previousValue, movie) => previousValue + movie.runtime,
    );

    return ProfileStateEntity(
      totalMoviesWatched: watchedMovies.length,
      totalMinutesWatched: totalMinutesWatched,
      mainGenresWatched: watchedMoviesToTopGenres(watchedMovies),
    );
  }
}
