import "package:movie_night_tcc/src/base/enums/storage_collections.enum.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/local_storage/local_storage_exception.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/result_type.dart";
import "package:movie_night_tcc/src/lib_mvvm/model/entity/movie.entity.dart";

final watchedStorage =
    MovieStorage(movieCollection: StorageCollections.watched);
final watchlistStorage =
    MovieStorage(movieCollection: StorageCollections.watchlist);

class MovieStorage {
  final ILocalStorage _localStorage = locator.get<ILocalStorage>();
  final String _collectionName;

  MovieStorage({required StorageCollections movieCollection})
      : _collectionName = movieCollection.collectionName;

  Future<Result<MovieModel?, LocalStorageException>> get({
    required String movieId,
  }) async {
    final result = await _localStorage.get<MovieModel>(
      collection: _collectionName,
      key: movieId,
    );
    if (result.hasError) {
      return Result.error(error: result.error!);
    }
    return Result.ok(data: result.data);
  }

  Future<Result<bool, LocalStorageException>> save({
    required MovieModel movie,
  }) async {
    final result = await _localStorage.save<MovieModel>(
      collection: _collectionName,
      key: movie.id,
      value: movie,
    );
    if (result.hasError) {
      return Result.error(error: result.error!);
    }
    return result;
  }

  Future<Result<bool, LocalStorageException>> delete({
    required String movieId,
  }) async {
    final result = await _localStorage.delete(
      collection: _collectionName,
      key: movieId,
    );
    return Result.ok(data: result);
  }

  Future<Result<bool, LocalStorageException>> hasKey({
    required String movieId,
  }) async {
    final result = await _localStorage.hasKey(
      collection: _collectionName,
      key: movieId,
    );
    if (result.hasError) {
      return Result.error(error: result.error!);
    }
    return Result.ok(data: result.data);
  }

  Future<Result<List<MovieModel>, LocalStorageException>> getAll() async {
    final result = await _localStorage.getAllFromCollection<MovieModel>(
      collection: _collectionName,
    );
    if (result.hasError) {
      return Result.error(error: result.error!);
    }
    return Result.ok(data: result.data);
  }

  Future<Result<bool, LocalStorageException>> clear() async {
    final result = await _localStorage.dropCollection(
      collection: _collectionName,
    );
    return Result.ok(data: result);
  }

  Future<Result<bool, LocalStorageException>> drop() async {
    final result = await _localStorage.dropCollection(
      collection: _collectionName,
    );

    return Result.ok(data: result);
  }
}
