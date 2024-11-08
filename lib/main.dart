import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/app_envs.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";

void main() async {
  setupLocator();
  await AppEnvs.init();
  await locator.get<ILocalStorage>().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: locator.get<INavigation>().routerConfig,
    );
  }
}
