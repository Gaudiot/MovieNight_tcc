part of "movie.api.dart";

@JsonSerializable(createFactory: false)
class GetTrendingMoviesRequest {
  final int page;

  GetTrendingMoviesRequest({required this.page});

  Map<String, dynamic> toJson() => _$GetTrendingMoviesRequestToJson(this);
}

@JsonSerializable()
class GetTrendingMoviesResponse {
  final int page;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "results", fromJson: _fromJsonIds)
  final List<int> ids;

  GetTrendingMoviesResponse({
    required this.ids,
    required this.page,
    required this.totalPages,
  });

  factory GetTrendingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTrendingMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTrendingMoviesResponseToJson(this);

  static List<int> _fromJsonIds(List<dynamic> movies) {
    return movies.map((movie) => movie["id"] as int).toList();
  }
}

class GetTrendingMoviesResponseMapper
    implements JsonMapper<GetTrendingMoviesResponse> {
  @override
  GetTrendingMoviesResponse fromJson(Map<String, dynamic> json) =>
      GetTrendingMoviesResponse.fromJson(json);

  @override
  Map<String, dynamic> toJson(GetTrendingMoviesResponse data) => data.toJson();
}

@JsonSerializable(createFactory: false)
class GetMoviesByTitleRequest {
  final String title;
  final int page;

  GetMoviesByTitleRequest({
    required this.title,
    required this.page,
  });

  Map<String, dynamic> toJson() => _$GetMoviesByTitleRequestToJson(this);
}

@JsonSerializable()
class GetMoviesByTitleResponse {
  final int page;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "results", fromJson: _fromJsonIds)
  final List<int> ids;

  GetMoviesByTitleResponse({
    required this.ids,
    required this.page,
    required this.totalPages,
  });

  static List<int> _fromJsonIds(List<dynamic> movies) {
    return movies.map((movie) => movie["id"] as int).toList();
  }

  factory GetMoviesByTitleResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMoviesByTitleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMoviesByTitleResponseToJson(this);
}

class GetMoviesByTitleResponseMapper
    implements JsonMapper<GetMoviesByTitleResponse> {
  @override
  GetMoviesByTitleResponse fromJson(Map<String, dynamic> json) =>
      GetMoviesByTitleResponse.fromJson(json);

  @override
  Map<String, dynamic> toJson(GetMoviesByTitleResponse data) => data.toJson();
}

@JsonSerializable(createFactory: false)
class GetMovieDetailsRequest {
  final int id;

  GetMovieDetailsRequest({required this.id});

  Map<String, dynamic> toJson() => _$GetMovieDetailsRequestToJson(this);
}

@JsonSerializable()
class GetMovieDetailsResponse {
  final int id;
  final String title;
  @JsonKey(name: "overview")
  final String synopsis;
  @JsonKey(name: "release_date", fromJson: _parseDate)
  final DateTime releaseDate;
  final int runtime;
  @JsonKey(name: "poster_path", fromJson: _buildImageUrl)
  final String? posterUrl;
  @JsonKey(name: "backdrop_path", fromJson: _buildImageUrl)
  final String? backdropUrl;
  @JsonKey(name: "genres", fromJson: _fromJsonGenres)
  final List<MovieGenre> genres;
  @JsonKey(name: "vote_average")
  final double rating;

  GetMovieDetailsResponse({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.releaseDate,
    required this.runtime,
    required this.posterUrl,
    required this.backdropUrl,
    required this.genres,
    required this.rating,
  });

  static List<MovieGenre> _fromJsonGenres(List<dynamic> genres) {
    final genreIds = genres.map((genre) => genre["id"] as int).toList();
    final tmdbGenres = genreIds.map((id) => TmdbMovieGenre.fromId(id)).toList();
    return tmdbGenres.map((genre) => genre.toMovieGenre()).toList();
  }

  static String _buildImageUrl(String imagePath) {
    return "https://image.tmdb.org/t/p/original$imagePath";
  }

  static DateTime _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return DateTime(0, 1, 1); // Retorna 0000-01-01 em caso de erro
    }
  }

  MovieModel toMovieModel() {
    return MovieModel(
      tmdbId: id,
      title: title,
      synopsis: synopsis,
      releaseDate: releaseDate,
      runtime: runtime,
      rating: rating,
      genres: genres,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
    );
  }

  Map<String, dynamic> toJson() => _$GetMovieDetailsResponseToJson(this);

  factory GetMovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMovieDetailsResponseFromJson(json);
}

class GetMovieDetailsResponseMapper
    implements JsonMapper<GetMovieDetailsResponse> {
  @override
  GetMovieDetailsResponse fromJson(Map<String, dynamic> json) =>
      GetMovieDetailsResponse.fromJson(json);

  @override
  Map<String, dynamic> toJson(GetMovieDetailsResponse data) => data.toJson();
}
