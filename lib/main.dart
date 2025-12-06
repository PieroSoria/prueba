import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/core/helpers/app_constants.dart';
import 'package:prueba/core/helpers/themes.dart';
import 'package:prueba/core/routes/app_routes.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';
import 'package:prueba/injector_dependency.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectorDependency();
  runApp(const BlocProviderData());
}

class BlocProviderData extends StatelessWidget {
  const BlocProviderData({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AppBloc>(create: (context) => sl())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: Themes.lightTheme,
          routerConfig: AppRoutes.onConfigRouter(),
        );
      },
    );
  }
}
