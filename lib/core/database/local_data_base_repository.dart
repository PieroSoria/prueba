import 'package:prueba/core/resources/data_state.dart';

enum TypePref { string, bool, int, double, listString }

enum GetSet { get, set, delete }

abstract class LocalDataBaseRepository {
  Future<DataState> getDataLocalRepository({
    required String table,
    Map<String, dynamic>? query,
  });
  Future<DataState> getDataLocalCustomSQLRepository({required String query});

  Future<DataState> saveDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  });
  Future<DataState> saveListDataLocalRepository({
    required String table,
    required List<dynamic> body,
  });
  Future<DataState> updateDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  });
  Future<DataState> deleteDataLocalRepository({
    required String table,
    required Map<String, dynamic> body,
  });
  Future<DataState> getAndSetDataPrefKey({
    required String key,
    dynamic item,
    required TypePref typePref,
    required GetSet getSet,
  });
  Future<DataState> getAndSetDataPrefKeySecurity({
    required String key,
    String? item,
    required GetSet getSet,
  });
}
