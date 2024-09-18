import "package:flutter/widgets.dart";
import "package:movie_night_tcc/lib_mvc/src/shared/app_colors.dart";

class AppFonts {
  static TextStyle robotoTextSmallerBold = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle robotoTextSmallRegular = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static TextStyle robotoTitleBigMedium = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle robotoTitleSmallMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
