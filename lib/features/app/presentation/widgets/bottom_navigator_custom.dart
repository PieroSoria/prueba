import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/helpers/responsive.dart';

class BottomNavigatorCustom extends StatefulWidget {
  final StatefulNavigationShell navigator;
  const BottomNavigatorCustom({super.key, required this.navigator});

  @override
  State<BottomNavigatorCustom> createState() => _BottomNavigatorCustomState();
}

class _BottomNavigatorCustomState extends State<BottomNavigatorCustom> {
  List<Map<String, dynamic>> listItems = [
    {'icon': Icons.language_rounded},
    {'icon': Icons.storage_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    final themedata = Theme.of(context);
    final padding = ResponsiveHelper.paddingHorizontal(2);
    final margin = ResponsiveHelper.paddingVertical(3);
    final iconSize = ResponsiveHelper.width(8);

    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.only(bottom: margin),
      decoration: BoxDecoration(
        color: themedata.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: padding,
        children: List.generate(
          listItems.length,
          (index) => GestureDetector(
            onTap: () {
              widget.navigator.goBranch(index);
            },
            child: Container(
              padding: EdgeInsets.all(padding * 0.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.navigator.currentIndex == index
                    ? Colors.white
                    : null,
              ),
              child: Icon(
                listItems[index]['icon'],
                size: iconSize,
                color: widget.navigator.currentIndex == index
                    ? themedata.colorScheme.primary
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
