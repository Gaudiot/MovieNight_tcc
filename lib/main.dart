import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/app_envs.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/lib_feature/main_feature.dart";
import "package:movie_night_tcc/src/lib_mvvm/main_mvvm.dart";

void main() async {
  setupLocator();
  await AppEnvs.init();
  await locator.get<ILocalStorage>().init();
  runApp(const MainApp());
}

enum AppType {
  featureBased,
  mvvmDefault,
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const appType = AppType.mvvmDefault;
    const appType = AppType.featureBased;

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: switch (appType) {
            AppType.featureBased => const MainFeatureBased(),
            AppType.mvvmDefault => const MainMvvmDefault(),
          },
        ),
      ),
    );
  }
}
