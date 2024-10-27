import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";

class GenericMovieError extends StatelessWidget {
  const GenericMovieError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.lib.assets.ticketBooth.svg(),
        const SizedBox(height: 26),
        Text(
          AppStrings.genericError,
          style: AppFonts.robotoTitleBigMedium,
        ),
      ],
    );
  }
}
