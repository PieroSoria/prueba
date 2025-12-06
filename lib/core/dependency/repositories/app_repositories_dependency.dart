import 'package:get_it/get_it.dart';
import 'package:prueba/features/app/data/repositories/app_repository_impl.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class AppRepositoriesDependency {
  static void injectorDependencyAppRepository(GetIt sl) {
    sl.registerLazySingleton<ProductGetApiRepository>(
      () => ProductGetApiRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<ProductGetLocalRepository>(
      () => ProductGetLocalRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<ProductSaveLocalRepository>(
      () => ProductCreateRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<ProductEditLocalRepository>(
      () => ProductEditRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<ProductDeleteLocalRepository>(
      () => ProductDeleteRepositoryImpl(sl()),
    );
  }
}
