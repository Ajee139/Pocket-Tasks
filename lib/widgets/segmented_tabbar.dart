import 'package:flutter/material.dart';

class SegmentedTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> segments;

  const SegmentedTabBar({
    super.key,
    required this.controller,
    required this.segments,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyMedium!.color;

    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / segments.length;

        return Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
             
              AnimatedBuilder(
  animation: controller.animation!,
  builder: (context, child) {
    final animationValue = controller.animation!.value.clamp(0.0, (segments.length - 1).toDouble());
    final left = animationValue * segmentWidth;

   return AnimatedPositioned(
  duration: const Duration(milliseconds: 250),
  left: left,
  width: segmentWidth,
  top: 0,
  bottom: 0,
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: primaryColor.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

  },
),

              Row(
                children: List.generate(segments.length, (index) {
                  final isSelected = controller.index == index;
                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: primaryColor.withValues(alpha: 0.1),
                      onTap: () => controller.animateTo(index),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? primaryColor : textColor,
                            fontSize: 14,
                          ),
                          child: Text(segments[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
