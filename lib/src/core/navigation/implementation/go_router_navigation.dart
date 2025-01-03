import "package:go_router/go_router.dart";
import "package:movie_night_tcc/src/base/enums/app_routes.enum.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_feature/details/details.view.dart"
    as feature;
import "package:movie_night_tcc/src/lib_feature/home/home.view.dart" as feature;
import "package:movie_night_tcc/src/lib_feature/home/movie.entity.dart"
    as feature;
import "package:movie_night_tcc/src/lib_feature/profile/ui/profile.view.dart"
    as feature;
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart"
    as mvvm;
import "package:movie_night_tcc/src/lib_mvvm/view/details.view.dart" as mvvm;
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
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      builder: (context, state) => const mvvm.HomeView(),
    ),
    GoRoute(
      name: AppRoutes.profile.name,
      path: AppRoutes.profile.path,
      builder: (context, state) => mvvm.ProfileView(),
    ),
    GoRoute(
      name: AppRoutes.details.name,
      path: AppRoutes.details.path,
      builder: (context, state) => mvvm.DetailsView(
        movieId: state.pathParameters["movieId"]!,
        movie: state.extra as mvvm.MovieModel?,
      ),
    ),
  ],
);

final _goRouterFeatureBased = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      builder: (context, state) => const feature.HomeView(),
    ),
    GoRoute(
      name: AppRoutes.profile.name,
      path: AppRoutes.profile.path,
      builder: (context, state) => feature.ProfileView(),
    ),
    GoRoute(
      name: AppRoutes.details.name,
      path: AppRoutes.details.path,
      builder: (context, state) => feature.DetailsView(
        movieId: state.pathParameters["movieId"]!,
        movie: state.extra as feature.MovieModel?,
      ),
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
  void push({
    required AppRoutes path,
    Map<String, String> pathParameters = const {},
    Object? data,
  }) {
    routerConfig.pushNamed(
      path.name,
      pathParameters: pathParameters,
      extra: data,
    );
  }

  @override
  void pop() {
    routerConfig.pop();
  }
}
