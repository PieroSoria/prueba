import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/resources/uses_cases.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class GetProductsLocalUseCase implements UseCase<DataState, int?> {
  final ProductGetLocalRepository productGetLocalRepository;

  GetProductsLocalUseCase({required this.productGetLocalRepository});
  @override
  Future<DataState> call({int? params}) async {
    return await productGetLocalRepository.getProductsLocal(id: params);
  }
}
