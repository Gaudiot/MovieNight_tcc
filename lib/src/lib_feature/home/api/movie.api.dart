import "package:json_annotation/json_annotation.dart";
import "package:movie_night_tcc/src/base/enums/movie_genre.enum.dart";
import "package:movie_night_tcc/src/core/app_envs.dart";
import "package:movie_night_tcc/src/core/json_mapper.dart";
import "package:movie_night_tcc/src/core/network/inetwork.dart";
import "package:movie_night_tcc/src/core/network/network_exception.dart";
import "package:movie_night_tcc/src/core/result_type.dart";
import "package:movie_night_tcc/src/lib_feature/home/movie.entity.dart";

part "movie.api.g.dart";
part "movie_api.enum.dart";
part "movie_api.model.dart";

class MovieApi {
  final INetwork _network = getNetwork(
    baseUrl: "https://api.themoviedb.org/3",
    authToken: AppEnvs.get("TMDB_API_KEY"),
  );

  Future<Result<GetTrendingMoviesResponse, NetworkException>>
      getTrendingMovies({
    required GetTrendingMoviesRequest request,
  }) async {
    return _network.get<GetTrendingMoviesResponse>(
      path: "/movie/popular",
      queryParameters: {
        "page": request.page.toString(),
      },
    );
  }

  Future<Result<GetMoviesByTitleResponse, NetworkException>> getMoviesByTitle({
    required GetMoviesByTitleRequest request,
  }) async {
    return _network.get<GetMoviesByTitleResponse>(
      path: "/search/movie",
      queryParameters: {
        "query": request.title,
        "page": request.page.toString(),
        "language": "pt-BR",
      },
    );
  }

  Future<Result<GetMovieDetailsResponse, NetworkException>> getMovieDetails({
    required GetMovieDetailsRequest request,
  }) async {
    return _network.get<GetMovieDetailsResponse>(
      path: "/movie/${request.id}",
      queryParameters: {
        "language": "pt-BR",
      },
    );
  }
}
