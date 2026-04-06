import 'package:flutter/material.dart';

class SimpleWidget {

  static Widget customContainer({
    required Widget child,
    bool hide = false,
    bool expanded = false,
    bool hideWidgetExpanded = false,
    Widget? hideWidget,
    double? width,
    double? height,
    double elevation = 0.0,
    double borderRadius = 0.0,
    AlignmentGeometry? alignment,
    Color bgColor = Colors.transparent,
    Color borderColor = Colors.transparent,
    Decoration? decoration,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets margin = EdgeInsets.zero,
    BoxConstraints? constraints,
    void Function()? onTap,
    bool showSplashOnTap = false,
    double opacity = 1.0,
  }) {

    if (hide && (!hideWidgetExpanded || hideWidget == null)) return hideWidget ?? Container();
    if (hide && hideWidgetExpanded) return Expanded(child: hideWidget!);

    Widget component = Container(
      constraints: constraints,
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: decoration ?? BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != Colors.transparent ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );

    if (onTap != null) {
      component = showSplashOnTap
          ? InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: component,
      )
          : GestureDetector(
        onTap: onTap,
        child: component,
      );
    }

    if (elevation > 0.0 || borderRadius > 0.0) {
      component = Material(
        elevation: elevation,
        color: Colors.white,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(borderRadius),
        child: component,
      );
    }

    if (margin != EdgeInsets.zero) {
      component = Container(
        margin: margin,
        child: component,
      );
    }

    if (opacity != 1.0) component = Opacity(opacity: opacity, child: component);

    return expanded ? Expanded(child: component) : component;
  }

}