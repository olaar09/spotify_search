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
    this.letterSpacing = -1,
  }) : super(key: key);

  factory BoldText.smaller(String text,
      {Color? color, TextAlign? align, FontWeight? fontWeight, int? maxLines}) {
    return BoldText(
      text: text,
      size: 12,
      color: color,
      fontWeight: fontWeight,
      maxLines: maxLines,
      align: align ?? TextAlign.left,
    );
  }

  factory BoldText.xSmaller(String text,
      {Color? color, FontWeight? fontWeight}) {
    return BoldText(
      text: text,
      size: 9,
      color: color,
      fontWeight: fontWeight,
    );
  }

  factory BoldText.smallerLighter(String text, {Color? color, int? maxLines}) {
    return BoldText.smaller(
      text,
      fontWeight: FontWeight.w400,
      color: color,
      maxLines: maxLines,
      align: TextAlign.left,
    );
  }

  factory BoldText.xSmallerLighter(String text, {Color? color}) {
    return BoldText.xSmallerLighter(
      text,
      color: color,
    );
  }

  factory BoldText.normal(String text,
      {Color? color, FontWeight? fontWeight, TextAlign? align}) {
    return BoldText(
      text: text,
      size: 16,
      color: color,
      fontWeight: fontWeight,
      align: align,
      maxLines: 9,
    );
  }

  factory BoldText.medium(String text,
      {Color? color, FontWeight? fontWeight, TextAlign? align}) {
    return BoldText(
      text: text,
      size: 14,
      color: color,
      fontWeight: fontWeight,
      align: align,
      maxLines: 9,
    );
  }

  factory BoldText.normalLighter(String text,
      {Color? color, TextAlign? align}) {
    return BoldText.normal(
      text,
      fontWeight: FontWeight.w500,
      color: color,
      align: align,
    );
  }

  factory BoldText.mediumLighter(String text,
      {Color? color, TextAlign? align}) {
    return BoldText.medium(
      text,
      fontWeight: FontWeight.w500,
      color: color,
      align: align,
    );
  }

  factory BoldText.larger(String text, {Color? color, FontWeight? fontWeight}) {
    return BoldText(
      text: text,
      size: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }

  factory BoldText.largerLighter(String text, {Color? color}) {
    return BoldText.larger(
      text,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  factory BoldText.xLarger(String text,
      {Color? color, FontWeight? fontWeight}) {
    return BoldText(
      text: text,
      size: 22,
      color: color,
      fontWeight: fontWeight,
    );
  }

  factory BoldText.xLargerLighter(String text, {Color? color}) {
    return BoldText.xLarger(
      text,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  factory BoldText.xxLarger(String text,
      {Color? color, FontWeight? fontWeight}) {
    return BoldText(
      text: text,
      size: 28,
      color: color,
      fontWeight: fontWeight,
    );
  }

  factory BoldText.xxLargerLighter(String text, {Color? color}) {
    return BoldText.xxLarger(
      text,
      fontWeight: FontWeight.w500,
      color: color,
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
        color: color ?? Colors.grey.shade800,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
