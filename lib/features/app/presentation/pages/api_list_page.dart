import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/components/content_type.dart';
import 'package:prueba/core/components/snackbar_custom.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/core/routes/menu/menu_routes.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';
import 'package:prueba/features/app/presentation/widgets/error_widget.dart';
import 'package:prueba/features/app/presentation/widgets/item_product_widget.dart';
import 'package:prueba/features/app/presentation/widgets/loading_widget.dart';

class ApiListPage extends StatefulWidget {
  const ApiListPage({super.key});

  @override
  State<ApiListPage> createState() => _ApiListPageState();
}

class _ApiListPageState extends State<ApiListPage> {
  @override
  void initState() {
    final appBloc = context.read<AppBloc>();
    appBloc.add(AppEvent.onGetListProductDataApi());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final appBloc = context.read<AppBloc>();
    final horizontalPadding = ResponsiveHelper.paddingHorizontal(8);
    final titleFontSize = ResponsiveHelper.fontSize(25);

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.productGetListApiFailure || state.productGetListApiUnkNown) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackbarCustom.show(
                title: state.title ?? '',
                message: state.message ?? '',
                contentType: state.productGetListApiFailure
                    ? ContentTypeNote.warning
                    : ContentTypeNote.failure,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Lista de Producto",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(RouteNames.apiListSearch.name);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state.productGetListApiLoading) {
                return LoadingWidget();
              }
              if (state.listProductsEmpty) {
                return ErrorWidgetCustom(
                  onTap: () {
                    appBloc.add(AppEvent.onGetListProductDataApi());
                  },
                );
              }
              return ListView.builder(
                itemCount: state.listProducts!.length,
                itemBuilder: (context, index) {
                  var product = state.listProducts![index];

                  return ItemProductWidget(product: product);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
