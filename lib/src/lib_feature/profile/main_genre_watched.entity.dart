import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";

class MainGenreWatched {
  final MovieGenre genre;
  final int quantity;

  MainGenreWatched({
    required this.genre,
    required this.quantity,
  });
}
