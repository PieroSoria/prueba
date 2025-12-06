import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/features/app/presentation/widgets/bottom_navigator_custom.dart';

class AppPage extends StatefulWidget {
  final StatefulNavigationShell navigator;
  const AppPage({super.key, required this.navigator});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final navHeight = ResponsiveHelper.height(10);

    return Scaffold(
      body: widget.navigator,
      extendBody: true,
      bottomNavigationBar: Container(
        height: navHeight,
        decoration: BoxDecoration(color: Colors.transparent),
        alignment: Alignment.bottomCenter,
        child: BottomNavigatorCustom(navigator: widget.navigator),
      ),
    );
  }
}
