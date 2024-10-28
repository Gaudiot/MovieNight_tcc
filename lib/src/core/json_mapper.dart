import "package:movie_night_tcc/src/lib_mvvm/model/movie.api.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/movie.entity.dart";

abstract class JsonMapper<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T data);
}

class MapperRegistry {
  static final Map<Type, JsonMapper> _mappers = {
    MovieModel: MovieModelMapper(),
    GetTrendingMoviesResponse: GetTrendingMoviesResponseMapper(),
    GetMovieDetailsResponse: GetMovieDetailsResponseMapper(),
    GetMoviesByTitleResponse: GetMoviesByTitleResponseMapper(),
  };

  static void register<T>(JsonMapper<T> mapper) {
    _mappers[T] = mapper;
  }

  static JsonMapper<T>? get<T>() {
    if (!_mappers.containsKey(T)) return null;

    return _mappers[T] as JsonMapper<T>;
  }
}
