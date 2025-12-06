import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final VoidCallback onTap;
  const ErrorWidgetCustom({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(),
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
                shape: RoundedRectangleBorder(borderRadius: .circular(15)),
              ),
              child: Text(
                "ReIntentar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
