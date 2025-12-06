import 'package:prueba/core/database/local_data_base_repository.dart';
import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_local.dart';
import 'package:prueba/features/app/data/models/product_model.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';

class AppDataSourceLocalImpl implements AppDataSourceLocal {
  final LocalDataBaseRepository localDataBaseRepository;

  AppDataSourceLocalImpl({required this.localDataBaseRepository});
  @override
  Future<DataState> saveProductLocal(ProductEntity product) async {
    return await localDataBaseRepository.saveDataLocalRepository(
      table: 'products',
      body: productModelToJson(product),
    );
  }

  @override
  Future<DataState> deleteProductLocal(int? id) async {
    return await localDataBaseRepository.deleteDataLocalRepository(
      table: 'products',
      body: {'id': id},
    );
  }

  @override
  Future<DataState> editProductLocal(ProductEntity product) async {
    return await localDataBaseRepository.updateDataLocalRepository(
      table: 'products',
      body: productModelToJson(product),
    );
  }

  @override
  Future<DataState> getProductsLocal({int? id}) async {
    return await localDataBaseRepository.getDataLocalRepository(
      table: 'products',
      query: id != null ? {'id': id} : null,
    );
  }
}
