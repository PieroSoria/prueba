import 'dart:ui';

import 'package:prueba/core/components/default_colors.dart';

class ContentTypeNote {
  final String message;

  final Color? color;

  const ContentTypeNote(this.message, [this.color]);

  static const ContentTypeNote help = ContentTypeNote(
    'help',
    DefaultColors.helpBlue,
  );
  static const ContentTypeNote failure = ContentTypeNote(
    'failure',
    DefaultColors.failureRed,
  );
  static const ContentTypeNote success = ContentTypeNote(
    'success',
    DefaultColors.successGreen,
  );
  static const ContentTypeNote warning = ContentTypeNote(
    'warning',
    DefaultColors.warningYellow,
  );
}
