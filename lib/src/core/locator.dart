import "package:get_it/get_it.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/local_storage/implementations/shared_preferences_storage.dart";

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ILocalStorage>(SharedPreferencesAsyncStorage());
}
