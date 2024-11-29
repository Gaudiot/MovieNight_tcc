import "package:movie_night_tcc/src/base/base_view_model.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/main_genre_watched.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/profile_state.entity.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/storage/movie.storage.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/transformer/profile.transformer.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";

class ProfileViewmodel extends BaseViewModel {
  final ProfileStateEntity _state = ProfileStateEntity();

  List<MainGenreWatched> get mainGenresWatched => _state.mainGenresWatched;
  ProfileStateEntity get profileState => _state;
  List<DateInfo> get watchedTimeInfo =>
      TimeUtils.runtimeToDateInfo(_state.totalMinutesWatched);

  Future<void> getProfile() async {
    setIsLoading(isLoading: true);

    final watchedStorageResult = await watchedStorage.getAll();
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

  Future<void> deleteUserData() async {
    await watchedStorage.drop();
    await watchlistStorage.drop();

    _state.updateWith(
      totalMoviesWatched: 0,
      totalMinutesWatched: 0,
      mainGenresWatched: [],
    );
    notifyListeners();
  }
}
