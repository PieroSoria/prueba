import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/resources/uses_cases.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class DeleteProductLocalUseCase implements UseCase<DataState, int?> {
  final ProductDeleteLocalRepository productDeleteLocalRepository;

  DeleteProductLocalUseCase({required this.productDeleteLocalRepository});
  @override
  Future<DataState> call({int? params}) async {
    return await productDeleteLocalRepository.deleteProductLocal(params);
  }
}
