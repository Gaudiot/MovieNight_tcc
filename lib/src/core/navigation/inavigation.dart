import "package:flutter/material.dart";
import "package:movie_night_tcc/src/base/enums/app_routes.enum.dart";

abstract class INavigation {
  RouterConfig<Object> get routerConfig;

  void goto({required AppRoutes path});
  void push({required AppRoutes path});
  void pop();
}
