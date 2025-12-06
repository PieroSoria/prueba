import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/components/content_type.dart';
import 'package:prueba/core/components/input_custom_core.dart';
import 'package:prueba/core/components/snackbar_custom.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/features/app/data/models/product_model.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';

class PrefsNewPage extends StatefulWidget {
  const PrefsNewPage({super.key});

  @override
  State<PrefsNewPage> createState() => _PrefsNewPageState();
}

class _PrefsNewPageState extends State<PrefsNewPage> {
  ProductEntity? selectedProduct;
  TextEditingController customNameController = TextEditingController();

  void saveProduct() {
    final appBloc = context.read<AppBloc>();
    if (selectedProduct == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackbarCustom.show(
            title: "Error",
            message: "Selecciona Un Producto",
            contentType: ContentTypeNote.warning,
          ),
        );
      return;
    }

    if (customNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackbarCustom.show(
            title: "Error",
            message: "Ingresa un Nombre Personalizado",
            contentType: ContentTypeNote.warning,
          ),
        );
      return;
    }
    final updateProduct = ProductModel.fromEntity(
      selectedProduct!,
    ).copyWith(name: customNameController.text);
    appBloc.add(AppEvent.onSaveProductDataLocal(productEntity: updateProduct));
  }

  @override
  void dispose() {
    customNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final themedata = Theme.of(context);
    final padding = ResponsiveHelper.paddingHorizontal(4);
    final spacing = ResponsiveHelper.paddingVertical(3);
    final buttonHeight = ResponsiveHelper.height(6);

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.productSaveLocalSuccess) {
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
        if (state.productSaveLocalFailure || state.productSaveLocalUnkNown) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackbarCustom.show(
                title: state.title ?? '',
                message: state.message ?? '',
                contentType: state.productSaveLocalFailure
                    ? ContentTypeNote.warning
                    : ContentTypeNote.failure,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Crear Nuevo Elemento",
            style: themedata.textTheme.titleMedium,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return DropdownButtonFormField<ProductEntity>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Selecciona un producto",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.paddingHorizontal(3),
                          vertical: ResponsiveHelper.paddingVertical(2),
                        ),
                      ),
                      initialValue: selectedProduct,
                      items: (state.listProducts ?? []).map((product) {
                        return DropdownMenuItem<ProductEntity>(
                          value: product,
                          child: Text(
                            product.title ?? "Producto sin título",
                            style: TextStyle(
                              fontSize: ResponsiveHelper.fontSize(14),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProduct = value;
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: spacing),
                InputCustomCore(
                  controller: customNameController,
                  title: "Nombre personalizado",
                ),
                SizedBox(height: spacing * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: ResponsiveHelper.paddingHorizontal(2),
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: saveProduct,
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            "Guardar",
                            style: TextStyle(
                              fontSize: ResponsiveHelper.fontSize(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: ResponsiveHelper.fontSize(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
