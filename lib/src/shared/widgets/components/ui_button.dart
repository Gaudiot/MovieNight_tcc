import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";

class UIButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  final double inkwellOpacity;

  const UIButton({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.inkwellOpacity = 0.5,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.white.withOpacity(inkwellOpacity),
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
