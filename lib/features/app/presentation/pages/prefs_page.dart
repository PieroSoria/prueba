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

class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});

  @override
  State<PrefsPage> createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  @override
  void initState() {
    final appBloc = context.read<AppBloc>();
    appBloc.add(AppEvent.onGetListProductDataLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final appBloc = context.read<AppBloc>();
    final horizontalPadding = ResponsiveHelper.paddingHorizontal(8);
    final titleFontSize = ResponsiveHelper.fontSize(18);

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.productDeletedLocalSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackbarCustom.show(
                title: state.title ?? '',
                message: state.message ?? '',
                contentType: ContentTypeNote.success,
              ),
            );
        }
        if (state.productDeletedLocalFailure ||
            state.productDeletedLocalUnkNown) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackbarCustom.show(
                title: state.title ?? '',
                message: state.message ?? '',
                contentType: state.productDeletedLocalFailure
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
            "Lista de Productos Guardados",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(RouteNames.prefsNewPage.name);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.productGetListLocalLoading) {
              return LoadingWidget();
            }
            if (state.listProductsLocalEmpty) {
              return ErrorWidgetCustom(
                onTap: () {
                  appBloc.add(AppEvent.onGetListProductDataLocal());
                },
              );
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              decoration: BoxDecoration(),
              child: ListView.builder(
                itemCount: state.listProductsLocal!.length,
                itemBuilder: (context, index) {
                  var product = state.listProductsLocal![index];
                  return ItemProductWidget(product: product, islocal: true);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
