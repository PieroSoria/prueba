import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/components/content_type.dart';
import 'package:prueba/core/components/input_custom_core.dart';
import 'package:prueba/core/components/snackbar_custom.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';

class PrefsIdPage extends StatefulWidget {
  const PrefsIdPage({super.key});

  @override
  State<PrefsIdPage> createState() => _PrefsIdPageState();
}

class _PrefsIdPageState extends State<PrefsIdPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    final appBloc = context.read<AppBloc>();
    titleController = TextEditingController(
      text: appBloc.state.productEntity?.title,
    );
    descriptionController = TextEditingController(
      text: appBloc.state.productEntity?.description,
    );
    categoryController = TextEditingController(
      text: appBloc.state.productEntity?.category,
    );
    priceController = TextEditingController(
      text: appBloc.state.productEntity?.price?.toString(),
    );
    stockController = TextEditingController(
      text: appBloc.state.productEntity?.stock?.toString(),
    );
    nameController = TextEditingController(
      text: appBloc.state.productEntity?.name?.toString(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final appBloc = context.read<AppBloc>();
    final updatedProduct = ProductEntity(
      id: appBloc.state.productEntity?.id,
      title: titleController.text,
      name: nameController.text,
      description: descriptionController.text,
      category: categoryController.text,
      price: double.tryParse(priceController.text) ?? 0.0,
      discountPercentage: appBloc.state.productEntity?.discountPercentage,
      rating: appBloc.state.productEntity?.rating,
      stock: int.tryParse(stockController.text) ?? 0,
      brand: appBloc.state.productEntity?.brand,
      sku: appBloc.state.productEntity?.sku,
      weight: appBloc.state.productEntity?.weight,
      warrantyInformation: appBloc.state.productEntity?.warrantyInformation,
      shippingInformation: appBloc.state.productEntity?.shippingInformation,
      availabilityStatus: appBloc.state.productEntity?.availabilityStatus,
      returnPolicy: appBloc.state.productEntity?.returnPolicy,
      minimumOrderQuantity: appBloc.state.productEntity?.minimumOrderQuantity,
      thumbnail: appBloc.state.productEntity?.thumbnail,
    );
    appBloc.add(
      AppEvent.onUpdatedProductDataLocal(productEntity: updatedProduct),
    );
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final appBloc = context.read<AppBloc>();
    final padding = ResponsiveHelper.paddingHorizontal(4);
    final imageHeight = ResponsiveHelper.height(35);
    final spacing = ResponsiveHelper.paddingVertical(2.5);
    final buttonHeight = ResponsiveHelper.height(6);
    final navHeight = ResponsiveHelper.height(10);

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.productEditLocalSuccess) {
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
        if (state.productEditLocalFailure || state.productEditLocalUnkNown) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackbarCustom.show(
                title: state.title ?? '',
                message: state.message ?? '',
                contentType: state.productEditLocalFailure
                    ? ContentTypeNote.warning
                    : ContentTypeNote.failure,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state.productEntity == null) {
                return Text("Loading");
              }
              return Text(
                state.productEntity?.title ?? 'Producto',
                style: TextStyle(fontSize: ResponsiveHelper.fontSize(18)),
              );
            },
          ),
          leading: BackButton(),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.pop();
                appBloc.add(
                  AppEvent.onDeletedProductDataLocal(
                    id: appBloc.state.productEntity!.id!,
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: imageHeight,
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: appBloc.state.productEntity?.thumbnail ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit, size: ResponsiveHelper.width(6)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputCustomCore(
                      controller: nameController,
                      title: "Nombre Personalizado",
                      hintText: "Escribe un nombre personalizado",
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing),
                    InputCustomCore(
                      controller: titleController,
                      title: "Titulo",
                      hintText: "Escribe un titulo",
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing),
                    InputCustomCore(
                      controller: descriptionController,
                      maxLines: 4,
                      title: "Descripción",
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing),
                    InputCustomCore(
                      controller: categoryController,
                      title: "Categoría",
                      hintText: "Escribe una categoria",
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing),
                    InputCustomCore(
                      controller: priceController,
                      title: "Precio",
                      textInputType: TextInputType.number,
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing),
                    InputCustomCore(
                      controller: stockController,
                      title: "Stock",
                      textInputType: TextInputType.number,
                      outTapEnabled: true,
                    ),
                    SizedBox(height: spacing * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: padding,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: buttonHeight,
                            child: BlocBuilder<AppBloc, AppState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.productEditLocalLoading
                                      ? null
                                      : saveChanges,
                                  child: state.productEditLocalLoading
                                      ? SizedBox(
                                          width: ResponsiveHelper.width(5),
                                          height: ResponsiveHelper.width(5),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Guardar",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ResponsiveHelper.fontSize(
                                              14,
                                            ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: buttonHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                context.pop();
                                appBloc.add(
                                  AppEvent.onDeletedProductDataLocal(
                                    id: appBloc.state.productEntity!.id!,
                                  ),
                                );
                              },
                              child: Text(
                                "Eliminar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveHelper.fontSize(14),
                                  fontWeight: FontWeight.w600,
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
              SizedBox(height: navHeight),
            ],
          ),
        ),
      ),
    );
  }
}
