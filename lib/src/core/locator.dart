import "package:get_it/get_it.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/local_storage/implementations/shared_preferences_storage.dart";
import "package:movie_night_tcc/src/core/navigation/implementation/go_router_navigation.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ILocalStorage>(SharedPreferencesAsyncStorage());
  locator.registerSingleton<INavigation>(GoRouterNavigation());
}
