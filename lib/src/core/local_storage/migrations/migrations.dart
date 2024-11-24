import "package:movie_night_tcc/src/core/local_storage/migrations/migration_001.dart";
import "package:shared_preferences/shared_preferences.dart";

abstract class MigrationData {
  final int id;

  MigrationData({
    required this.id,
  });

  Future<bool> migration();
}

class Migrations {
  Migrations._();

  static final List<MigrationData> _migrations = [
    Migration001(),
  ];

  static Future<int> _getLastMigrationId() async {
    final sharedPreferences = SharedPreferencesAsync();
    final lastMigrationId =
        (await sharedPreferences.getInt("last_migration_id")) ?? 0;
    return lastMigrationId;
  }

  static Future<bool> _saveLastMigrationId(int id) async {
    final sharedPreferences = SharedPreferencesAsync();
    await sharedPreferences.setInt("last_migration_id", id);
    return true;
  }

  static void resetMigrationCounter() {
    final sharedPreferences = SharedPreferencesAsync();
    sharedPreferences.remove("last_migration_id");
  }

  static Future<void> run() async {
    final lastMigrationId = await _getLastMigrationId();

    for (var id = lastMigrationId; id < _migrations.length; id++) {
      final migration = _migrations[id];
      assert(
        migration.id == id,
        "Migration $id is not defined or not in order",
      );
      final success = await migration.migration();
      if (success) {
        await _saveLastMigrationId(id);
      } else {
        throw Exception("Migration $id failed");
      }
    }
  }
}
