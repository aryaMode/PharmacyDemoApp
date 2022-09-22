import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ReorderableLayout extends StatelessWidget {
  final bool reorderable;
  final EdgeInsetsGeometry? padding;
  final double spacing, childAspectRatio;
  final int crossAxisCount;
  final void Function(int oldIndex, int newIndex) onReorder;
  final List<Widget>? footer;
  final List<Widget>? children;

  const ReorderableLayout({
    Key? key,
    this.reorderable = true,
    this.padding,
    this.spacing = 15,
    required this.crossAxisCount,
    required this.onReorder,
    required this.children,
    this.footer,
    this.childAspectRatio = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reorderable
        ? ReorderableGridView(
            shrinkWrap: true,
            padding: padding,
            onReorder: onReorder,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            children: children
                    ?.map((child) => Container(
                          key: ValueKey(child),
                          child: child,
                        ))
                    .toList() ??
                <Widget>[],
            footer: footer,
          )
        : GridView(
            shrinkWrap: true,
            padding: padding,
            scrollDirection: Axis.vertical,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            children:
                (children as List<Wi>?? <Widget>[]) + (footer != null ? footer! : []),
          );
  }
}
