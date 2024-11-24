import "package:movie_night_tcc/src/lib_feature/search_movies/movie.api.dart"
    as feature;
import "package:movie_night_tcc/src/lib_feature/search_movies/movie.entity.dart"
    as feature;
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart"
    as mvvm;
import "package:movie_night_tcc/src/lib_mvvm/model/movie.api.dart" as mvvm;

abstract class JsonMapper<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T data);
}

class MapperRegistry {
  static final Map<Type, JsonMapper> _mappers = {
    mvvm.MovieModel: mvvm.MovieModelMapper(),
    mvvm.GetTrendingMoviesResponse: mvvm.GetTrendingMoviesResponseMapper(),
    mvvm.GetMovieDetailsResponse: mvvm.GetMovieDetailsResponseMapper(),
    mvvm.GetMoviesByTitleResponse: mvvm.GetMoviesByTitleResponseMapper(),
    feature.MovieModel: feature.MovieModelMapper(),
    feature.GetTrendingMoviesResponse:
        feature.GetTrendingMoviesResponseMapper(),
    feature.GetMovieDetailsResponse: feature.GetMovieDetailsResponseMapper(),
    feature.GetMoviesByTitleResponse: feature.GetMoviesByTitleResponseMapper(),
  };

  static void register<T>(JsonMapper<T> mapper) {
    _mappers[T] = mapper;
  }

  static JsonMapper<T>? get<T>() {
    if (!_mappers.containsKey(T)) return null;

    return _mappers[T] as JsonMapper<T>;
  }
}
