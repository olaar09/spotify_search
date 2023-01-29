import 'package:flutter/material.dart';

class PagePadding extends EdgeInsets {
  static const double defaultValue = 9;

  const PagePadding.horizontalSymmetric({double? value})
      : super.symmetric(horizontal: value ?? defaultValue);

  const PagePadding.verticalSymmetric({double? value})
      : super.symmetric(vertical: value ?? defaultValue);

  const PagePadding.general({double? value})
      : super.only(
          right: value ?? defaultValue,
          left: value ?? defaultValue,
          top: value ?? defaultValue,
          bottom: value ?? defaultValue,
        );

  const PagePadding.only({double? right, left, top, bottom})
      : super.only(
          right: right ?? defaultValue,
          left: left ?? defaultValue,
          top: top ?? defaultValue,
          bottom: bottom ?? defaultValue,
        );
}
