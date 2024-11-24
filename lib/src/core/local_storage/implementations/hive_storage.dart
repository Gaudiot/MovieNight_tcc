import "dart:convert";

import "package:hive/hive.dart";
import "package:movie_night_tcc/src/core/json_mapper.dart";
import "package:movie_night_tcc/src/core/local_storage/ilocal_storage.dart";
import "package:movie_night_tcc/src/core/local_storage/local_storage_exception.dart";
import "package:movie_night_tcc/src/core/result_type.dart";
import "package:path_provider/path_provider.dart";

extension HiveExtension on HiveInterface {
  Future<Box<String>> getBox(String collection) async {
    final isBoxOpen = Hive.isBoxOpen(collection);
    if (!isBoxOpen) return Hive.openBox<String>(collection);
    return Hive.openBox<String>(collection);
  }
}

class HiveException extends LocalStorageException {
  HiveException({
    super.message,
  }) : super(
          localStorageProvider: "Hive",
        );
}

class HiveStorage extends ILocalStorage {
  String _encodeData<T>(T data) {
    if (T == int || T == double || T == String || T == bool) {
      return jsonEncode(data);
    }

    final mapper = MapperRegistry.get<T>();
    if (mapper == null) throw Exception("Mapper for type $T not found");
    return jsonEncode(mapper.toJson(data));
  }

  T _decodeData<T>(String data) {
    if (T == int || T == double || T == String || T == bool) {
      return jsonDecode(data);
    }

    final mapper = MapperRegistry.get<T>();
    if (mapper == null) throw Exception("Mapper for type $T not found");
    return mapper.fromJson(jsonDecode(data));
  }

  @override
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    super.init();
  }

  @override
  Future<Result<bool, HiveException>> hasKey({
    required String collection,
    required String key,
  }) async {
    try {
      final box = await Hive.getBox(collection);
      return Result.ok(data: box.containsKey(key));
    } catch (error) {
      return Result.error(error: HiveException(message: error.toString()));
    }
  }

  @override
  Future<Result<T, HiveException>> get<T>({
    required String collection,
    required String key,
  }) async {
    try {
      final box = await Hive.getBox(collection);
      final encodedData = box.get(key);
      if (encodedData == null) return Result.ok(data: null);

      return Result.ok(data: _decodeData<T>(encodedData));
    } catch (e) {
      return Result.error(error: HiveException(message: e.toString()));
    }
  }

  @override
  Future<Result<List<T>, HiveException>> getAllFromCollection<T>({
    required String collection,
  }) async {
    try {
      final box = await Hive.getBox(collection);
      final data = box.values.map(_decodeData<T>).toList();
      return Result.ok(data: data);
    } catch (error) {
      return Result.error(error: HiveException(message: error.toString()));
    }
  }

  @override
  Future<Result<bool, HiveException>> save<T>({
    required String collection,
    required String key,
    required T value,
  }) async {
    try {
      final box = await Hive.getBox(collection);
      final encodedData = _encodeData<T>(value);
      await box.put(key, encodedData);
      return Result.ok(data: true);
    } catch (error) {
      return Result.error(error: HiveException(message: error.toString()));
    }
  }

  @override
  Future<bool> delete({required String collection, required String key}) async {
    try {
      final box = await Hive.getBox(collection);
      await box.delete(key);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> dropCollection({required String collection}) async {
    try {
      final box = await Hive.getBox(collection);
      await box.clear();
      return true;
    } catch (error) {
      return false;
    }
  }
}
