import "package:go_router/go_router.dart";
import "package:movie_night_tcc/src/base/enums/app_routes.enum.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_feature/home/home.view.dart" as feature;
import "package:movie_night_tcc/src/lib_feature/profile/profile.view.dart"
    as feature;
import "package:movie_night_tcc/src/lib_mvvm/view/home.view.dart" as mvvm;
import "package:movie_night_tcc/src/lib_mvvm/view/profile.view.dart" as mvvm;

enum AppType {
  featureBased,
  mvvmDefault,
}

final _goRouterMvvm = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const mvvm.HomeView(),
    ),
    GoRoute(
      path: AppRoutes.profile.path,
      builder: (context, state) => mvvm.ProfileView(),
    ),
  ],
);

final _goRouterFeatureBased = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const feature.HomeView(),
    ),
    GoRoute(
      path: AppRoutes.profile.path,
      builder: (context, state) => feature.ProfileView(),
    ),
  ],
);

class GoRouterNavigation implements INavigation {
  static const appType = AppType.mvvmDefault;
  // static const appType = AppType.featureBased;

  @override
  GoRouter get routerConfig => switch (appType) {
        AppType.mvvmDefault => _goRouterMvvm,
        AppType.featureBased => _goRouterFeatureBased,
      };

  @override
  void goto({required AppRoutes path}) {
    routerConfig.go(path.path);
  }

  @override
  void push({required AppRoutes path}) {
    routerConfig.push(path.path);
  }

  @override
  void pop() {
    routerConfig.pop();
  }
}
