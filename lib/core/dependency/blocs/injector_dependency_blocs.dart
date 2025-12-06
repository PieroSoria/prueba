import 'package:get_it/get_it.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';

class InjectorDependecyBlocs {
  static void injectorDependecyBlocs(GetIt sl) {
    sl.registerFactory<AppBloc>(() => AppBloc(sl(), sl(), sl(), sl(), sl()));
  }
}
