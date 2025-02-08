import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_ignite/models/app_exception.dart';

class ThemeUtils {
  static const mobileWidth = 768;
  static const tabletWidth = 1024;
  static const desktopWidth = 1280;

  static isDesktop(final double width) => width >= desktopWidth;
  static isTablet(final double width) =>
      width > mobileWidth && width < desktopWidth;
  static isMobile(final double width) => width <= mobileWidth && width > 600;

  static double responsive(final double width,
      {required final double mobile,
      required final double tablet,
      required final double desktop,
      required final double fallback}) {
    if (isDesktop(width)) return desktop;
    if (isTablet(width)) return tablet;
    if (isMobile(width)) return mobile;
    return fallback;
  }

  static Size calculateContentSize(final Widget widget) {
    RenderBox renderBox = widget.createElement().renderObject as RenderBox;
    renderBox.layout(BoxConstraints.loose(Size.infinite));
    return renderBox.size;
  }

  static buildResponsiveGridView(
    context, {
    required final List<Widget> children,
    int count = 3,
    final int? mobileCount = 1,
    final int? tabletCount = 2,
    final int? desktopCount,
    final double? aspectRatio,
    final Axis scrollDirection = Axis.vertical,
    final String type = "count",
  }) {
    if ("count" == type) {
      if (MediaQuery.of(context).size.width < tabletWidth) {
        count = mobileCount ?? count;
      } else if (MediaQuery.of(context).size.width < desktopWidth) {
        count = tabletCount ?? count;
      } else {
        count = desktopCount ?? count;
      }
      return GridView.count(
          crossAxisCount: count,
          childAspectRatio:
              aspectRatio ?? MediaQuery.of(context).size.height / 400,
          shrinkWrap: true,
          scrollDirection: scrollDirection,
          children: children);
    } else if ("extent" == type) {
      double maxWidth = 0;
      for (Widget item in children) {
        maxWidth = math.max(calculateContentSize(item).width, maxWidth);
      }
      return GridView.extent(
        maxCrossAxisExtent: maxWidth,
        shrinkWrap: true,
        children: children,
      );
    } else {
      throw AppException(
          name: "InvalidGridViewException",
          message: "Invalid GridView",
          description:
              "Gridview.$type cannot be rendered. Implementation required");
    }
  }
}
