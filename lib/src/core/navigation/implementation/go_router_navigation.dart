import "package:go_router/go_router.dart";
import "package:movie_night_tcc/src/base/enums/app_routes.enum.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/home.view.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/profile.view.dart";

enum AppType {
  featureBased,
  mvvmDefault,
}

final _goRouterMvvm = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.profile.path,
      builder: (context, state) => ProfileView(),
    ),
  ],
);

class GoRouterNavigation implements INavigation {
  static const appType = AppType.mvvmDefault;

  @override
  GoRouter get routerConfig => switch (appType) {
        AppType.mvvmDefault => _goRouterMvvm,
        AppType.featureBased => _goRouterMvvm,
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
