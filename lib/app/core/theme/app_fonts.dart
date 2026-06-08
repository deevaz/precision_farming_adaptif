import 'package:flutter/material.dart';

abstract class AppFonts {
  static final AppFontSize _fontSize = AppFontSize._();
  static final TextStyle _default = TextStyle(
    height: 0,
    // fontFamily: "PlusJakartaSans",
    // fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle get xsRegular {
    return _default.copyWith(
      fontSize: _fontSize.x10,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get xsMedium {
    return _default.copyWith(
      fontSize: _fontSize.x10,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get xsBold {
    return _default.copyWith(
      fontSize: _fontSize.x10,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get smRegular {
    return _default.copyWith(
      fontSize: _fontSize.x12,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get smMedium {
    return _default.copyWith(
      fontSize: _fontSize.x12,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get smSemiBold {
    return _default.copyWith(
      fontSize: _fontSize.x12,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get smBold {
    return _default.copyWith(
      fontSize: _fontSize.x12,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get mdRegular {
    return _default.copyWith(
      fontSize: _fontSize.x14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get mdMedium {
    return _default.copyWith(
      fontSize: _fontSize.x14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get mdSemiBold {
    return _default.copyWith(
      fontSize: _fontSize.x14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get mdBold {
    return _default.copyWith(
      fontSize: _fontSize.x14,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get lgRegular {
    return _default.copyWith(
      fontSize: _fontSize.x16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get lgMedium {
    return _default.copyWith(
      fontSize: _fontSize.x16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get lgSemiBold {
    return _default.copyWith(
      fontSize: _fontSize.x16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get lgBold {
    return _default.copyWith(
      fontSize: _fontSize.x16,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get xlMedium {
    return _default.copyWith(
      fontSize: _fontSize.x18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get xlBold {
    return _default.copyWith(
      fontSize: _fontSize.x18,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get xlSemiBold {
    return _default.copyWith(
      fontSize: _fontSize.x18,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get xxlBold {
    return _default.copyWith(
      fontSize: _fontSize.x22,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get xxxlBold {
    return _default.copyWith(
      fontSize: _fontSize.x28,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get xxxxlMedium {
    return _default.copyWith(
      fontSize: _fontSize.x30,
      fontWeight: FontWeight.w500,
    );
  }
}

class AppFontSize {
  AppFontSize._();

  double get x10 => 10;
  double get x12 => 12;
  double get x14 => 14;
  double get x16 => 16;
  double get x18 => 18;
  double get x20 => 20;
  double get x22 => 22;
  double get x24 => 24;
  double get x28 => 28;
  double get x30 => 30;
  double get x32 => 32;
  double get x36 => 36;
  double get x48 => 48;
  double get x60 => 60;
}
