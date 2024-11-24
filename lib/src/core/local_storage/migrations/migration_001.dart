import "package:movie_night_tcc/src/core/local_storage/migrations/migrations.dart";

class Migration001 implements MigrationData {
  @override
  final int id = 0;

  Migration001();

  @override
  Future<bool> migration() async {
    try {
      print("Migration 001");
      return true;
    } catch (e) {
      return false;
    }
  }
}
