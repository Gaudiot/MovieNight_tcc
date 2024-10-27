import "package:movie_night_tcc/src/core/network/implementations/dio_network.dart";
import "package:movie_night_tcc/src/core/network/network_exception.dart";
import "package:movie_night_tcc/src/core/result_type.dart";

abstract class INetwork {
  void setBaseUrl({
    required String baseUrl,
  });

  Future<Result<T, NetworkException>> get<T>({
    required String path,
    Map<String, String?>? queryParameters = const {},
  });

  Future<Result<S, NetworkException>> post<T, S>({
    required String path,
    required T body,
  });

  Future<Result<S, NetworkException>> put<T, S>({
    required String path,
    required T body,
  });

  Future<Result<T, NetworkException>> delete<T>({
    required String path,
  });
}

INetwork getNetwork({required String baseUrl, String? authToken}) {
  final network = DioNetwork();
  network.setBaseUrl(
    baseUrl: baseUrl,
    authToken: authToken ?? "",
  );
  return network;
}
