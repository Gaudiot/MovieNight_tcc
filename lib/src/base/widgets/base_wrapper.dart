import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";

class BaseWrapper extends StatelessWidget {
  final Widget? appBar;
  final Widget child;

  const BaseWrapper({
    required this.child,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkestBlue,
        body: Column(
          children: [
            if (appBar != null) appBar!,
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
