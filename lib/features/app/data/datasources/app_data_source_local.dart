import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';

abstract class AppDataSourceLocal {
  Future<DataState> getProductsLocal({int? id});
  Future<DataState> saveProductLocal(ProductEntity product);
  Future<DataState> editProductLocal(ProductEntity product);
  Future<DataState> deleteProductLocal(int? id);
}
