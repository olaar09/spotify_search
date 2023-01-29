import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final int? maxLines;
  final double? letterSpacing;

  const BoldText({
    Key? key,
    required this.text,
    this.size,
    this.align,
    this.color,
    this.fontWeight,
    this.maxLines = 2,
    this.letterSpacing,
  }) : super(key: key);

  factory BoldText.small(String text,
      {Color? color,
      TextAlign? align,
      FontWeight? fontWeight = FontWeight.w600,
      int? maxLines}) {
    return BoldText(
      text: text,
      size: 12,
      color: color,
      fontWeight: fontWeight,
      maxLines: maxLines,
      align: align ?? TextAlign.left,
      letterSpacing: 0,
    );
  }

  factory BoldText.medium(String text,
      {Color? color,
      FontWeight? fontWeight = FontWeight.w500,
      TextAlign? align}) {
    return BoldText(
      text: text,
      size: 14,
      color: color,
      fontWeight: fontWeight,
      align: align,
      maxLines: 9,
      letterSpacing: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align ?? TextAlign.left,
      style: TextStyle(
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w900,
        fontSize: size ?? 20,
        color: color ?? Colors.grey.shade500,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
