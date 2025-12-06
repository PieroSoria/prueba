import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';

abstract class ProductGetApiRepository {
  Future<DataState> getProducts();
}

abstract class ProductGetLocalRepository {
  Future<DataState> getProductsLocal({int? id});
}

abstract class ProductSaveLocalRepository {
  Future<DataState> saveProductLocal(ProductEntity product);
}

abstract class ProductEditLocalRepository {
  Future<DataState> editProductLocal(ProductEntity product);
}

abstract class ProductDeleteLocalRepository {
  Future<DataState> deleteProductLocal(int? id);
}
