import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/resources/uses_cases.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class EditProductLocalUseCase implements UseCase<DataState, ProductEntity> {
  final ProductEditLocalRepository productEditLocalRepository;

  EditProductLocalUseCase({required this.productEditLocalRepository});
  @override
  Future<DataState> call({ProductEntity? params}) async {
    return await productEditLocalRepository.editProductLocal(params!);
  }
}
