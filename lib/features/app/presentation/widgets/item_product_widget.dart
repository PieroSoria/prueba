import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/core/routes/menu/menu_routes.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';

class ItemProductWidget extends StatelessWidget {
  const ItemProductWidget({
    super.key,
    required this.product,
    this.islocal = false,
  });

  final ProductEntity product;
  final bool islocal;

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final appBloc = context.read<AppBloc>();

    final bottomPadding = ResponsiveHelper.paddingVertical(2);
    final containerPadding = ResponsiveHelper.paddingHorizontal(2.5);
    final imageSize = ResponsiveHelper.width(18);
    final textSize = ResponsiveHelper.fontSize(14);
    final titleSize = ResponsiveHelper.fontSize(16);
    final buttonHeight = ResponsiveHelper.height(5);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.paddingVertical(0.5)),
                      Text(
                        "Categoria: ${product.category}\nPrecio: \$${product.price}",
                        style: TextStyle(fontSize: textSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ResponsiveHelper.paddingHorizontal(2)),
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  child: product.thumbnail != null
                      ? CachedNetworkImage(
                          imageUrl: product.thumbnail ?? '',
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.photo_size_select_actual,
                          size: imageSize * 0.5,
                        ),
                ),
              ],
            ),
            if (islocal) ...[
              SizedBox(height: ResponsiveHelper.paddingVertical(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: ResponsiveHelper.paddingHorizontal(2),
                children: [
                  Expanded(
                    child: SizedBox(
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          appBloc.add(
                            AppEvent.onSelectProductData(
                              productEntity: product,
                            ),
                          );
                          context.pushNamed(
                            RouteNames.prefsIdPage.name,
                            pathParameters: {'id': '@'},
                          );
                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(14),
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          appBloc.add(
                            AppEvent.onDeletedProductDataLocal(id: product.id!),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Eliminar",
                          style: TextStyle(
                            fontSize: ResponsiveHelper.fontSize(14),
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
