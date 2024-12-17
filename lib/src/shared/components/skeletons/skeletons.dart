import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";

class TextSkeleton extends StatelessWidget {
  final String text;
  final TextStyle style;

  const TextSkeleton({
    required this.text,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
