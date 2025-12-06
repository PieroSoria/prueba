import 'package:flutter/material.dart';
import 'package:prueba/core/helpers/responsive.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final VoidCallback onTap;
  const ErrorWidgetCustom({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final themedata = Theme.of(context);
    final containerWidth = ResponsiveHelper.width(80);
    final buttonFontSize = ResponsiveHelper.fontSize(14);
    final borderRadius = BorderRadius.circular(ResponsiveHelper.width(3));

    return Center(
      child: Container(
        width: containerWidth,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              "Hubo Un Problema en obtener los datos que buscas, Intentar denuevo mas tarde",
              textAlign: TextAlign.center,
              style: themedata.textTheme.bodyLarge,
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
              ),
              child: Text(
                "ReIntentar",
                style: TextStyle(fontSize: buttonFontSize, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
