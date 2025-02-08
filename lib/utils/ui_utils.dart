import 'package:flutter/material.dart';

class UIUtils {
  static void scrollToTarget({required final GlobalKey key, required final ScrollController controller, final double offset = 0.0, final duration =300}) {
    // Scrollable.ensureVisible(key.currentContext!, duration: Duration(milliseconds: duration));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = key.currentContext!.findRenderObject() as RenderBox;
      final targetWidgetOffset = renderBox.localToGlobal(Offset.zero);
      final scrollPosition = controller.offset;
      final desiredPosition = targetWidgetOffset.dy - offset;
      controller.animateTo(
        // Scrollable.ensureBoxOffset(key.currentContext) - offset,
        desiredPosition - scrollPosition,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInOut,
      );
    });
  }
}