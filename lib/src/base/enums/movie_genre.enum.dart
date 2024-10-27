enum MovieGenre {
  unknown(id: 0, label: "Genrer"),
  action(id: 1, label: "Action"),
  adventure(id: 2, label: "Adventure"),
  animation(id: 3, label: "Animation"),
  comedy(id: 4, label: "Comedy"),
  crime(id: 5, label: "Crime"),
  documentary(id: 6, label: "Documentary"),
  drama(id: 7, label: "Drama"),
  family(id: 8, label: "Family"),
  fantasy(id: 9, label: "Fantasy"),
  history(id: 10, label: "History"),
  horror(id: 11, label: "Horror"),
  music(id: 12, label: "Music"),
  mystery(id: 13, label: "Mystery"),
  romance(id: 14, label: "Romance"),
  scienceFiction(id: 15, label: "Science Fiction"),
  tvMovie(id: 16, label: "TV Movie"),
  thriller(id: 17, label: "Thriller"),
  war(id: 18, label: "War"),
  western(id: 19, label: "Western");

  final int id;
  final String label;

  const MovieGenre({required this.id, required this.label});

  static MovieGenre fromId(int id) {
    return MovieGenre.values.firstWhere(
      (genre) => genre.id == id,
      orElse: () => MovieGenre.unknown,
    );
  }
}
