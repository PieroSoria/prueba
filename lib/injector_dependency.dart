import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/core/api/api_client.dart';
import 'package:prueba/core/api/api_client_repository.dart';
import 'package:prueba/core/database/init_services_database.dart';
import 'package:prueba/core/database/local_data_base_repository.dart';
import 'package:prueba/core/database/local_data_base_repository_impl.dart';
import 'package:prueba/core/dependency/blocs/injector_dependency_blocs.dart';
import 'package:prueba/core/dependency/datasources/app_data_sources_dependency.dart';
import 'package:prueba/core/dependency/repositories/app_repositories_dependency.dart';
import 'package:prueba/core/dependency/use_cases/app_use_cases_dependency.dart';
import 'package:prueba/core/helpers/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> injectorDependency() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  const securedStorage = FlutterSecureStorage();
  final mydb = await InitServicesDatabase.initialDataBaseServices();
  sl.registerLazySingleton<FlutterSecureStorage>(() => securedStorage);
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<ApiClientRepository>(
    () => ApiClient(baseUrl: AppConstants.baseUrl),
  );
  sl.registerLazySingleton<LocalDataBaseRepository>(
    () => LocalDataBaseRepositoryImpl(
      mydb: mydb,
      sharedPreferences: sl<SharedPreferences>(),
      flutterSecureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  AppDataSourcesDependency.injectorDependencyAppDataSource(sl);
  AppRepositoriesDependency.injectorDependencyAppRepository(sl);
  AppUseCasesDependency.injectorDependencyAppUseCases(sl);
  InjectorDependecyBlocs.injectorDependecyBlocs(sl);
}
