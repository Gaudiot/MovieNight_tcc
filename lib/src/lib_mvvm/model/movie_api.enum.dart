part of "movie.api.dart";

enum TmdbMovieGenre {
  unknown(id: 0),
  action(id: 28),
  adventure(id: 12),
  animation(id: 16),
  comedy(id: 35),
  crime(id: 80),
  documentary(id: 99),
  drama(id: 18),
  family(id: 10751),
  fantasy(id: 14),
  history(id: 36),
  horror(id: 27),
  music(id: 10402),
  mystery(id: 9648),
  romance(id: 10749),
  scienceFiction(id: 878),
  tvMovie(id: 10770),
  thriller(id: 53),
  war(id: 10752),
  western(id: 37);

  final int id;

  const TmdbMovieGenre({required this.id});

  static TmdbMovieGenre fromId(int id) {
    return TmdbMovieGenre.values.firstWhere(
      (genre) => genre.id == id,
      orElse: () => TmdbMovieGenre.unknown,
    );
  }

  MovieGenre toMovieGenre() {
    return switch (this) {
      TmdbMovieGenre.action => MovieGenre.action,
      TmdbMovieGenre.adventure => MovieGenre.adventure,
      TmdbMovieGenre.animation => MovieGenre.animation,
      TmdbMovieGenre.comedy => MovieGenre.comedy,
      TmdbMovieGenre.crime => MovieGenre.crime,
      TmdbMovieGenre.documentary => MovieGenre.documentary,
      TmdbMovieGenre.drama => MovieGenre.drama,
      TmdbMovieGenre.family => MovieGenre.family,
      TmdbMovieGenre.fantasy => MovieGenre.fantasy,
      TmdbMovieGenre.history => MovieGenre.history,
      TmdbMovieGenre.horror => MovieGenre.horror,
      TmdbMovieGenre.music => MovieGenre.music,
      TmdbMovieGenre.mystery => MovieGenre.mystery,
      TmdbMovieGenre.romance => MovieGenre.romance,
      TmdbMovieGenre.scienceFiction => MovieGenre.scienceFiction,
      TmdbMovieGenre.tvMovie => MovieGenre.tvMovie,
      TmdbMovieGenre.thriller => MovieGenre.thriller,
      TmdbMovieGenre.war => MovieGenre.war,
      TmdbMovieGenre.western => MovieGenre.western,
      _ => MovieGenre.unknown,
    };
  }
}
