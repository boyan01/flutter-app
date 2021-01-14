import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/brightness_observer.dart';
import 'package:flutter_app/widgets/unread_text.dart';

import 'interacter_decorated_box.dart';

class SelectItem extends StatelessWidget {
  const SelectItem({
    this.title,
    this.icon,
    this.count = 0,
    this.onTap,
    this.selected = false,
    this.onRightClick,
  });

  final Widget icon;
  final String title;
  final bool selected;
  final int count;
  final VoidCallback onTap;
  final ValueChanged<PointerUpEvent> onRightClick;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    );
    return InteractableDecoratedBox.color(
      onTap: onTap,
      onRightClick: onRightClick,
      decoration: selected == true
          ? boxDecoration.copyWith(
              color: BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(0, 0, 0, 0.06),
              darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
            ))
          : boxDecoration,
      hoveringColor: BrightnessData.dynamicColor(
        context,
        const Color.fromRGBO(0, 0, 0, 0.03),
        darkColor: const Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        final hideTitle = boxConstraints.maxWidth < 75;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8),
              if (!hideTitle)
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: BrightnessData.dynamicColor(
                        context,
                        const Color.fromRGBO(51, 51, 51, 1),
                        darkColor: const Color.fromRGBO(255, 255, 255, 0.9),
                      ),
                      fontSize: 14,
                    ),
                  ),
                ),
              UnreadText(
                count: count,
                backgroundColor: BrightnessData.dynamicColor(
                  context,
                  const Color.fromRGBO(51, 51, 51, 0.16),
                  darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
                ),
                textColor: BrightnessData.dynamicColor(
                  context,
                  const Color.fromRGBO(51, 51, 51, 1),
                  darkColor: const Color.fromRGBO(44, 49, 54, 0.8),
                ),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        );
      }),
    );
  }
}