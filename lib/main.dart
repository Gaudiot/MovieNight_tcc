import 'package:flutter/material.dart';
import 'package:movie_night_tcc/lib_feature/main_feature.dart';
import 'package:movie_night_tcc/lib_mvc/main_mvc.dart';

void main() {
  runApp(const MainApp());
}

enum AppType {
  featureBased,
  mvcDefault,
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appType = AppType.featureBased;

    return MaterialApp(
      home: Scaffold(
        body: switch (appType) {
          AppType.featureBased => const MainFeatureBased(),
          AppType.mvcDefault => const MainMvcDefault(),
        },
      ),
    );
  }
}
