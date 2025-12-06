import 'package:flutter/foundation.dart';
import 'package:prueba/core/helpers/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba/core/database/local_data_base_repository.dart';
import 'package:prueba/core/resources/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBaseRepositoryImpl implements LocalDataBaseRepository {
  final Database mydb;
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage flutterSecureStorage;
  LocalDataBaseRepositoryImpl({
    required this.mydb,
    required this.sharedPreferences,
    required this.flutterSecureStorage,
  });

  @override
  Future<DataState> deleteDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  }) async {
    try {
      String whereKeys = body.keys.map((key) => '$key = ?').join(' AND ');
      List<dynamic> valuesData = body.values.toList();

      final result = await mydb.delete(
        table,
        where: whereKeys,
        whereArgs: valuesData,
      );
      if (result == 0) {
        return DataFailed(
          errorMessage: ErrorMessage(
            title: "No eliminado",
            message:
                "No se encontró ningún registro en '$table' con los criterios proporcionados.",
          ),
        );
      }
      return DataSuccess(
        ResultSuccess(
          title: "Éxito",
          message: "Se eliminaron $result registros de la tabla '$table'.",
          data: result,
        ),
      );
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> getDataLocalRepository({
    required String table,
    Map<String, dynamic>? query,
  }) async {
    try {
      String whereKeys = '';
      List<dynamic> valuesData = [];
      if (query != null && query.isNotEmpty) {
        whereKeys = query.keys.map((key) => '$key = ?').join(' AND ');
        valuesData = query.values.toList();
      }
      final data = await mydb.query(
        table,
        where: query != null ? whereKeys : null,
        whereArgs: query != null ? valuesData : null,
      );
      if (data.isEmpty) {
        return DataFailed(
          errorMessage: ErrorMessage(
            title: "Error",
            message: "No se Encontro Productos Guardados",
          ),
        );
      }
      return DataSuccess(
        ResultSuccess(
          title: "Exito",
          message: "Se Encontraron Productos",
          data: data,
        ),
      );
    } catch (e) {
      LoggerHelper.error('error local database $e');
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> saveDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  }) async {
    try {
      final cleanBody = Map<String, dynamic>.from(body)
        ..removeWhere((key, value) => value == null);

      final id = cleanBody["id"];

      if (id != null) {
        final existing = await mydb.query(
          table,
          where: "id = ?",
          whereArgs: [id],
        );

        if (existing.isNotEmpty) {
          return DataFailed(
            errorMessage: ErrorMessage(
              title: "ID duplicado",
              message:
                  "Ya existe un registro con el id '$id' en la tabla '$table'.",
            ),
          );
        }
      }

      final result = await mydb.insert(
        table,
        cleanBody,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      if (result == 0) {
        return DataFailed(
          errorMessage: ErrorMessage(
            title: "No insertado",
            message: "El registro no se pudo insertar en la tabla '$table'.",
          ),
        );
      }

      return DataSuccess(
        ResultSuccess(
          title: "Éxito",
          message: "Registro insertado correctamente.",
          data: cleanBody,
        ),
      );
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  List<Map<String, dynamic>> listDataConver(List<dynamic> data) {
    return data.map((e) {
      final original = Map<String, dynamic>.from(e);
      final filtered = <String, dynamic>{};
      original.forEach((key, value) {
        if (value != null) {
          filtered[key] = value;
        }
      });
      return filtered;
    }).toList();
  }

  @override
  Future<DataState> saveListDataLocalRepository({
    required String table,
    required List<dynamic> body,
  }) async {
    try {
      final listdata = await compute(listDataConver, body);

      int insertedCount = 0;

      for (var data in listdata) {
        final result = await mydb.insert(
          table,
          data,
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        if (result != 0) {
          insertedCount++;
        }
      }
      if (insertedCount == 0) {
        return DataFailed(
          errorMessage: ErrorMessage(
            title: "No insertado",
            message:
                "Ninguna fila pudo insertarse en la tabla '$table'. Puede que ya existan o hubo conflictos.",
          ),
        );
      }
      return DataSuccess(
        ResultSuccess(
          title: "Éxito",
          message:
              "Filas insertadas correctamente: $insertedCount de ${body.length}",
          data: insertedCount,
        ),
      );
    } catch (e) {
      LoggerHelper.error('Error base de datos $e');
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> updateDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  }) async {
    try {
      String whereKeys = body.keys.map((key) => '$key = ?').join(' AND ');
      List<dynamic> valuesData = body.values.toList();
      final result = await mydb.update(
        table,
        body,
        where: whereKeys,
        whereArgs: valuesData,
      );
      return DataSuccess(ResultSuccess(data: result));
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> getAndSetDataPrefKey({
    required String key,
    dynamic item,
    required TypePref typePref,
    required GetSet getSet,
  }) async {
    try {
      if (getSet == GetSet.get) {
        final data = switch (typePref) {
          TypePref.string => sharedPreferences.getString(key),
          TypePref.bool => sharedPreferences.getBool(key),
          TypePref.double => sharedPreferences.getDouble(key),
          TypePref.int => sharedPreferences.getInt(key),
          TypePref.listString => sharedPreferences.getStringList(key),
        };
        return DataSuccess(ResultSuccess(data: data));
      } else if (getSet == GetSet.set) {
        final result = await switch (typePref) {
          TypePref.string => sharedPreferences.setString(key, item),
          TypePref.bool => sharedPreferences.setBool(key, item),
          TypePref.double => sharedPreferences.setDouble(key, item),
          TypePref.int => sharedPreferences.setInt(key, item),
          TypePref.listString => sharedPreferences.setStringList(key, item),
        };
        return DataSuccess(ResultSuccess(data: result));
      } else {
        final result = await sharedPreferences.remove(key);
        return DataSuccess(ResultSuccess(data: result));
      }
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> getAndSetDataPrefKeySecurity({
    required String key,
    String? item,
    required GetSet getSet,
  }) async {
    try {
      if (getSet == GetSet.get) {
        final result = await flutterSecureStorage.read(key: key);
        if (result != null) {
          return DataSuccess(ResultSuccess(data: result));
        } else {
          return DataFailed(
            errorMessage: ErrorMessage(
              title: "Error",
              message: "No se Encontro el Dato",
            ),
          );
        }
      } else if (getSet == GetSet.set) {
        await flutterSecureStorage.write(key: key, value: item);
        return DataSuccess(
          ResultSuccess(title: "Exito", message: "Se guardo con exito"),
        );
      } else {
        await flutterSecureStorage.delete(key: key);
        return DataSuccess(
          ResultSuccess(title: "Exito", message: "Se elimino con exito"),
        );
      }
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<DataState> getDataLocalCustomSQLRepository({
    required String query,
  }) async {
    try {
      final List<Map<String, dynamic>> result = await mydb.rawQuery(query);
      return DataSuccess(ResultSuccess(data: result));
    } catch (e) {
      LoggerHelper.error('Error en getDataLocalCustomSQLRepository: $e');
      return DataFailed(
        errorMessage: ErrorMessage(
          title: "Error",
          message: "Unknown error: ${e.toString()}",
        ),
      );
    }
  }
}
