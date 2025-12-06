import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/resources/uses_cases.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class SaveProductLocalUseCase implements UseCase<DataState, ProductEntity> {
  final ProductSaveLocalRepository productSaveLocalRepository;

  SaveProductLocalUseCase({required this.productSaveLocalRepository});
  @override
  Future<DataState> call({ProductEntity? params}) async {
    return await productSaveLocalRepository.saveProductLocal(params!);
  }
}
