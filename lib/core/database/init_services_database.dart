import 'package:path/path.dart';
import 'package:prueba/core/helpers/app_constants.dart';

import 'package:sqflite/sqflite.dart';

class InitServicesDatabase {
  static Future<Database> initialDataBaseServices() async {
    String path = await getDatabasesPath();
    String pathjoin = join(path, "prueba.db");
    Database mydb = await openDatabase(
      pathjoin,
      onCreate: (db, version) async {
        for (var data in AppConstants.createTableSQL) {
          await db.execute(
            data,
            // 'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
          );
        }
      },
      version: 1,
    );
    return mydb;
  }
}
