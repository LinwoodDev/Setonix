import 'package:flutter/material.dart';
import 'package:material_leap/helpers.dart';

class TwoChildRowLayout extends StatelessWidget {
  final Widget primary, second;
  final double breakpoint;
  const TwoChildRowLayout({
    super.key,
    required this.primary,
    required this.second,
    this.breakpoint = LeapBreakpoints.compact,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < breakpoint) {
        return Column(
          children: [
            second,
            const SizedBox(height: 12),
            primary,
          ],
        );
      }
      return Row(
        children: [
          Expanded(child: primary),
          const SizedBox(width: 64),
          second,
        ],
      );
    });
  }
}
