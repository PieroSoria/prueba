import 'package:prueba/core/api/api_client_repository.dart';
import 'package:prueba/core/helpers/app_constants.dart';
import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/features/app/data/datasources/app_data_source_remote.dart';

class AppDataSourceRemoteImpl implements AppDataSourceRemote {
  final ApiClientRepository apiClientRepository;

  AppDataSourceRemoteImpl({required this.apiClientRepository});
  @override
  Future<DataState> getProductsRemote() async {
    return await apiClientRepository.requestApiData(
      AppConstants.urlGetProducts,
      method: ApiMethod.get,
    );
  }
}
