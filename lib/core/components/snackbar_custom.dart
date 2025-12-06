import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import 'package:prueba/core/components/content_type.dart';
import 'package:prueba/core/helpers/app_svg_message.dart';

class SnackbarCustom {
  static SnackBar show({
    required String title,
    required String message,
    required ContentTypeNote contentType,
    TextStyle? titleTextStyle,
    TextStyle? messageTextStyle,
    Color? backgroundColor,
  }) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        titleTextStyle: titleTextStyle,
        messageTextStyle: messageTextStyle,
      ),
    );
  }
}

class AwesomeSnackbarContent extends StatelessWidget {
  final String title;
  final String message;
  final Color? color;
  final ContentTypeNote contentType;
  final bool inMaterialBanner;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;

  const AwesomeSnackbarContent({
    super.key,
    this.color,
    this.titleTextStyle,
    this.messageTextStyle,
    required this.title,
    required this.message,
    required this.contentType,
    this.inMaterialBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final size = MediaQuery.sizeOf(context);
    bool isMobile = size.width <= 768;
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    double leftSpace = size.width * 0.12;
    double rightSpace = size.width * 0.12;

    return Container(
      // margin: EdgeInsets.symmetric(
      //   horizontal: horizontalPadding,
      // ),
      width: size.width,
      height: size.height * 0.150,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                AssetsPath.bubbles,
                height: size.height * 0.06,
                width: size.width * 0.05,
                colorFilter: _getColorFilter(
                  hslDark.toColor(),
                  ui.BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Bubble Icon
          Positioned(
            top: -size.height * 0.015,
            left: !isRTL
                ? leftSpace -
                      8 -
                      (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            right: isRTL
                ? rightSpace -
                      8 -
                      (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.back,
                  height: size.height * 0.06,
                  colorFilter: _getColorFilter(
                    hslDark.toColor(),
                    ui.BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  top: size.height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(contentType),
                    height: size.height * 0.022,
                  ),
                ),
              ],
            ),
          ),

          /// content
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// `title` parameter
                    Expanded(
                      child: Text(
                        title,
                        style:
                            titleTextStyle ??
                            TextStyle(
                              fontSize: (!isMobile
                                  ? size.height * 0.03
                                  : size.height * 0.025),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (inMaterialBanner) {
                          ScaffoldMessenger.of(
                            context,
                          ).hideCurrentMaterialBanner();
                          return;
                        }
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: size.height * 0.022,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.005,
                // ),
                Expanded(
                  child: Text(
                    message,
                    style:
                        messageTextStyle ??
                        TextStyle(
                          fontSize: size.height * 0.016,
                          color: Colors.white,
                        ),
                  ),
                ),
                SizedBox(height: size.height * 0.015),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String assetSVG(ContentTypeNote contentType) {
    switch (contentType) {
      case ContentTypeNote.failure:
        return AssetsPath.failure;
      case ContentTypeNote.success:
        return AssetsPath.success;
      case ContentTypeNote.warning:
        return AssetsPath.warning;
      case ContentTypeNote.help:
        return AssetsPath.help;
      default:
        return AssetsPath.failure;
    }
  }

  static ColorFilter? _getColorFilter(
    ui.Color? color,
    ui.BlendMode colorBlendMode,
  ) => color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}
