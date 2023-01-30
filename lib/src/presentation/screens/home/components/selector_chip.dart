import 'package:emoodie/src/core/components/padding.dart';
import 'package:emoodie/src/core/components/text.dart';
import 'package:emoodie/src/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

class SelectorChip extends StatefulWidget {
  final bool isActive;
  final String text;
  final Function() onSelect;

  const SelectorChip({
    Key? key,
    required this.isActive,
    required this.text,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<SelectorChip> createState() => _SelectorChipState();
}

class _SelectorChipState extends State<SelectorChip> {
  final isActiveColor = Colors.green;
  final isIdleColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final chipColor = widget.isActive ? isActiveColor : isIdleColor;

    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        padding: const PagePadding.only(
          top: 8.0,
          bottom: 8.0,
          right: 16.0,
          left: 16.0,
        ),
        decoration: BoxDecoration(
          color: chipColor.shade900,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: chipColor.shade500,
            width: 1.2,
          ),
        ),
        child: BoldText(
          text: widget.text,
          size: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          letterSpacing: .1,
        ),
      ),
    );
  }
}
