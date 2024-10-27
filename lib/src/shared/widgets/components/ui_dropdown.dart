import "package:dropdown_button2/dropdown_button2.dart";
import "package:flutter/material.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";

class UIDropdown<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;

  final List<DropdownMenuItem<T>> items;

  const UIDropdown({
    required this.items,
    this.value,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        items: items,
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(
              color: AppColors.white,
            ),
          ),
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 500,
          decoration: BoxDecoration(
            color: AppColors.darkBlue,
          ),
        ),
        style: AppFonts.robotoTextSmallRegular,
      ),
    );
  }
}

class UIDropdownMovies extends StatelessWidget {
  final MovieGenre? value;
  final ValueChanged<MovieGenre?>? onChanged;

  const UIDropdownMovies({
    super.key,
    this.onChanged,
    this.value = MovieGenre.unknown,
  });

  @override
  Widget build(BuildContext context) {
    return UIDropdown<int>(
      value: value?.id,
      onChanged: (newGenreId) {
        onChanged?.call(MovieGenre.fromId(newGenreId ?? 0));
      },
      items: MovieGenre.values
          .map(
            (genre) => DropdownMenuItem<int>(
              value: genre.id,
              child: Text(genre.label),
            ),
          )
          .toList(),
    );
  }
}
