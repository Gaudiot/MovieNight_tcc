import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/base/enums/storage_collections.enum.dart";
import "package:movie_night_tcc/src/lib_feature/profile/main_genre_watched.entity.dart";
import "package:movie_night_tcc/src/lib_feature/profile/profile.transformer.dart";
import "package:movie_night_tcc/src/lib_feature/profile/profile_state.entity.dart";
import "package:movie_night_tcc/src/lib_feature/search_movies/movie.storage.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";

class ProfileViewmodel extends BaseViewModel {
  final _watchedLocalStorage =
      MovieStorage(movieCollection: StorageCollections.watched);
  final _watchlistLocalStorage =
      MovieStorage(movieCollection: StorageCollections.watchlist);

  final ProfileStateEntity _state = ProfileStateEntity();

  List<MainGenreWatched> get mainGenresWatched => _state.mainGenresWatched;
  ProfileStateEntity get profileState => _state;

  Future<void> getProfile() async {
    setIsLoading(isLoading: true);

    final watchedStorageResult = await _watchedLocalStorage.getAll();
    if (watchedStorageResult.hasError) return;

    final watchedMovies = watchedStorageResult.data!;

    final profileState =
        ProfileTransformer.watchedMoviesToProfileState(watchedMovies);

    _state.updateWith(
      totalMoviesWatched: profileState.totalMoviesWatched,
      totalMinutesWatched: profileState.totalMinutesWatched,
      mainGenresWatched: profileState.mainGenresWatched,
    );

    setIsLoading(isLoading: false);
  }

  List<DateInfo> getWatchedTimeInfo() {
    return runtimeToDateInfo(_state.totalMinutesWatched);
  }

  Future<void> deleteUserData() async {
    await _watchedLocalStorage.drop();
    await _watchlistLocalStorage.drop();
  }
}
