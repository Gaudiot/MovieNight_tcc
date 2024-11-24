import "package:json_annotation/json_annotation.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/json_mapper.dart";

part "movie.entity.g.dart";

@JsonSerializable()
class MovieModel {
  final int tmdbId;
  final String title;
  final String synopsis;
  final DateTime releaseDate;
  final int runtime;
  final String? posterUrl;
  final String? backdropUrl;
  final List<MovieGenre> genres;
  double rating;
  bool favorite;

  String get id => tmdbId.toString();

  MovieModel({
    required this.tmdbId,
    required this.title,
    required this.synopsis,
    required this.releaseDate,
    required this.rating,
    required this.runtime,
    required this.genres,
    this.posterUrl,
    this.backdropUrl,
    this.favorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

class MovieModelMapper implements JsonMapper<MovieModel> {
  @override
  MovieModel fromJson(Map<String, dynamic> json) {
    return MovieModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MovieModel data) {
    return data.toJson();
  }
}
