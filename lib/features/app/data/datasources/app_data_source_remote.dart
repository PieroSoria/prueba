import 'package:prueba/core/resources/data_state.dart';

abstract class AppDataSourceRemote {
  Future<DataState> getProductsRemote();
}
