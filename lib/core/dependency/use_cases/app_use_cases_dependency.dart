import 'package:get_it/get_it.dart';
import 'package:prueba/features/app/domain/usecases/delete_product_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/edit_product_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/get_products_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/get_products_use_case.dart';
import 'package:prueba/features/app/domain/usecases/save_product_local_use_case.dart';

class AppUseCasesDependency {
  static void injectorDependencyAppUseCases(GetIt sl) {
    sl.registerLazySingleton(
      () => GetProductsUseCase(productGetApiRepository: sl()),
    );

    sl.registerLazySingleton(
      () => GetProductsLocalUseCase(productGetLocalRepository: sl()),
    );

    sl.registerLazySingleton(
      () => SaveProductLocalUseCase(productSaveLocalRepository: sl()),
    );

    sl.registerLazySingleton(
      () => EditProductLocalUseCase(productEditLocalRepository: sl()),
    );

    sl.registerLazySingleton(
      () => DeleteProductLocalUseCase(productDeleteLocalRepository: sl()),
    );
  }
}
