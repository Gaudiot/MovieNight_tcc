import "package:movie_night_tcc/src/lib_mvvm/model/entity/main_genre_watched.entity.dart";

class ProfileStateEntity {
  int totalMoviesWatched;
  int totalMinutesWatched;
  List<MainGenreWatched> mainGenresWatched;

  ProfileStateEntity({
    this.totalMoviesWatched = 0,
    this.totalMinutesWatched = 0,
    this.mainGenresWatched = const [],
  });

  void updateWith({
    int? totalMoviesWatched,
    int? totalMinutesWatched,
    List<MainGenreWatched>? mainGenresWatched,
  }) {
    this.totalMoviesWatched = totalMoviesWatched ?? this.totalMoviesWatched;
    this.totalMinutesWatched = totalMinutesWatched ?? this.totalMinutesWatched;
    this.mainGenresWatched = mainGenresWatched ?? this.mainGenresWatched;
  }
}
