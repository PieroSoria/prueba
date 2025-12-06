import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_local.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_remote.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class ProductGetApiRepositoryImpl implements ProductGetApiRepository {
  final AppDataSourceRemote remote;

  ProductGetApiRepositoryImpl(this.remote);

  @override
  Future<DataState> getProducts() async {
    return await remote.getProductsRemote();
  }
}

class ProductGetLocalRepositoryImpl implements ProductGetLocalRepository {
  final AppDataSourceLocal local;

  ProductGetLocalRepositoryImpl(this.local);

  @override
  Future<DataState> getProductsLocal({int? id}) async {
    return await local.getProductsLocal(id: id);
  }
}

class ProductCreateRepositoryImpl implements ProductSaveLocalRepository {
  final AppDataSourceLocal local;

  ProductCreateRepositoryImpl(this.local);

  @override
  Future<DataState> saveProductLocal(ProductEntity product) {
    return local.saveProductLocal(product);
  }
}

class ProductEditRepositoryImpl implements ProductEditLocalRepository {
  final AppDataSourceLocal local;

  ProductEditRepositoryImpl(this.local);

  @override
  Future<DataState> editProductLocal(ProductEntity product) {
    return local.editProductLocal(product);
  }
}

class ProductDeleteRepositoryImpl implements ProductDeleteLocalRepository {
  final AppDataSourceLocal local;

  ProductDeleteRepositoryImpl(this.local);

  @override
  Future<DataState> deleteProductLocal(int? id) {
    return local.deleteProductLocal(id);
  }
}
