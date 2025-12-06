import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/routes/app_routes.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';
import 'package:prueba/features/app/presentation/pages/api_list_page.dart';
import 'package:prueba/features/app/presentation/pages/api_list_search_page.dart';
import 'package:prueba/features/app/presentation/pages/app_page.dart';
import 'package:prueba/features/app/presentation/pages/prefs_id_page.dart';
import 'package:prueba/features/app/presentation/pages/prefs_new_page.dart';
import 'package:prueba/features/app/presentation/pages/prefs_page.dart';

enum RouteNames {
  apiList(path: '/api-list', name: 'Api List Page'),
  apiListSearch(path: '/search', name: 'Api List Search Page'),
  prefsPage(path: '/prefs', name: 'Prefs Page'),
  prefsNewPage(path: '/new', name: 'Prefs New Page'),
  prefsIdPage(path: '/:id', name: 'Prefs Id Page');

  final String path;
  final String name;

  const RouteNames({required this.path, required this.name});
}

class AppRoutesMenu {
  static StatefulShellRoute menuRoutes = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, statefulnavigator) => AppRoutes.viewMaterial(
      state.pageKey,
      AppPage(navigator: statefulnavigator),
    ),
    branches: [
      StatefulShellBranch(
        initialLocation: RouteNames.apiList.path,
        navigatorKey: AppRoutes.onDashboardNavigatorKey,
        preload: false,
        routes: [
          GoRoute(
            path: RouteNames.apiList.path,
            name: RouteNames.apiList.name,
            pageBuilder: (context, state) =>
                AppRoutes.viewMaterial(state.pageKey, ApiListPage()),
            routes: [
              GoRoute(
                path: RouteNames.apiListSearch.path,
                name: RouteNames.apiListSearch.name,
                pageBuilder: (context, state) =>
                    AppRoutes.viewMaterial(state.pageKey, ApiListSearchPage()),
              ),
            ],
          ),
        ],
      ),

      StatefulShellBranch(
        initialLocation: RouteNames.prefsPage.path,
        navigatorKey: AppRoutes.onSettingsNavigatorKey,
        preload: false,
        routes: [
          GoRoute(
            path: RouteNames.prefsPage.path,
            name: RouteNames.prefsPage.name,
            pageBuilder: (context, state) =>
                AppRoutes.viewMaterial(state.pageKey, PrefsPage()),
            routes: [
              GoRoute(
                path: RouteNames.prefsNewPage.path,
                name: RouteNames.prefsNewPage.name,
                pageBuilder: (context, state) =>
                    AppRoutes.viewMaterial(state.pageKey, PrefsNewPage()),
              ),
              GoRoute(
                path: RouteNames.prefsIdPage.path,
                name: RouteNames.prefsIdPage.name,
                pageBuilder: (context, state) {
                  final appBloc = context.read<AppBloc>();
                  final id = state.pathParameters['id'];
                  if (id != null && id != "@") {
                    appBloc.add(
                      AppEvent.onGetProductDataLocal(id: int.parse(id)),
                    );
                  }
                  return AppRoutes.viewMaterial(state.pageKey, PrefsIdPage());
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
