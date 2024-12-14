enum AppRoutes {
  home(path: "/"),
  profile(path: "/profile"),
  details(path: "/details/:movieId");

  final String path;

  const AppRoutes({required this.path});
}
