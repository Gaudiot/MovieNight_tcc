enum AppRoutes {
  profile(path: "/profile"),
  home(path: "/");

  final String path;

  const AppRoutes({required this.path});
}
