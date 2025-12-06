import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/resources/uses_cases.dart';
import 'package:prueba/features/app/domain/repositories/app_repository_interface.dart';

class GetProductsUseCase implements UseCase<DataState, void> {
  final ProductGetApiRepository productGetApiRepository;

  GetProductsUseCase({required this.productGetApiRepository});
  @override
  Future<DataState> call({void params}) async {
    return await productGetApiRepository.getProducts();
  }
}
