import 'package:get_it/get_it.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_local.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_remote.dart';
import 'package:prueba/features/app/data/datasources/impl/app_data_source_local_impl.dart';
import 'package:prueba/features/app/data/datasources/impl/app_data_source_remote_impl.dart';

class AppDataSourcesDependency {
  static void injectorDependencyAppDataSource(GetIt sl) {
    sl.registerLazySingleton<AppDataSourceLocal>(
      () => AppDataSourceLocalImpl(localDataBaseRepository: sl()),
    );

    sl.registerLazySingleton<AppDataSourceRemote>(
      () => AppDataSourceRemoteImpl(apiClientRepository: sl()),
    );
  }
}
