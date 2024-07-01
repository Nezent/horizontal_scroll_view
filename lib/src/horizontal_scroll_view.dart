import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:horizontal_scroll_view/src/scroll_physics.dart';

class HorizontalScrollView extends StatefulWidget {
  /// The `HorizontalScrollView` widget allows you to create a horizontal list view
  /// with customizable properties such as the number of items per row, spacing
  /// between items, and scroll control. You can populate the list either by
  /// providing a predefined list of children or by using a builder function to
  /// create each item dynamically.
  ///
  /// [itemWidth] specifies the number of items to display per row.
  /// [crossAxisSpacing] sets the spacing between items in the same row.
  /// [alignment] defines the alignment of items within the rows (default is center).
  /// [children] is a list of child widgets
  ///
  /// Example usage:
  ///
  /// ```
  /// HorizontalScrollView(
  ///   itemWidth: 2,
  ///   crossAxisSpacing: 8.0,
  ///   controller: myController,
  ///   children: [
  ///     // List of child widgets
  ///     // ...
  ///   ],
  /// )
  /// ```
  HorizontalScrollView({
    required this.itemWidth,
    required this.crossAxisSpacing,
    this.alignment = CrossAxisAlignment.center,
    required this.children,
    super.key,
  })  : itemCount = children!.length,
        itemBuilder = null;

  /// Creates a `HorizontalScrollView` using a builder function.
  ///
  /// [itemWidth] specifies the number of items to display per row.
  /// [crossAxisSpacing] sets the spacing between items in the same row.
  /// [alignment] defines the alignment of items within the rows (default is center).
  /// [itemCount] is the total number of items in the list.
  /// [itemBuilder] is a callback function to build each item widget based on the index.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// HorizontalScrollView.builder(
  ///   itemWidth: 2,
  ///   crossAxisSpacing: 8.0,
  ///   controller: myController,
  ///   itemCount: itemCount,
  ///   itemBuilder: (context, index) {
  ///     // Build each item dynamically based on the index
  ///     return MyCustomItemWidget(index: index);
  ///   },
  /// )
  /// ```
  const HorizontalScrollView.builder({
    required this.itemWidth,
    this.crossAxisSpacing = 0,
    this.alignment = CrossAxisAlignment.center,
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  }) : children = null;

  /// [itemWidth] specifies the number of items to display per row.
  final double itemWidth;

  /// [crossAxisSpacing] sets the spacing between items in the same row.
  final double crossAxisSpacing;

  /// [alignment] defines the alignment of items within the rows (default is center).
  final CrossAxisAlignment? alignment;

  /// [itemCount] is the total number of items in the list.
  final int itemCount;

  /// [children] is a list of child widgets.
  final List<Widget>? children;

  /// [itemBuilder] is a callback function to build each item widget.
  final Widget Function(BuildContext context, int index)? itemBuilder;

  @override
  State<HorizontalScrollView> createState() => _HorizontalScrollViewState();
}

class _HorizontalScrollViewState extends State<HorizontalScrollView> {
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Key _key = UniqueKey();

  int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: _key,
      builder: (context, constraints) {
        double snapSize = constraints.maxWidth + widget.crossAxisSpacing;

        SnapScrollSize scrollPhysics = SnapScrollSize(snapSize: snapSize);

        if (!_key.toString().contains(snapSize.toString())) {
          Future.delayed(Duration.zero, () {
            setState(() {
              rebuildAllChildren(context);
              _key = new Key('snap-$snapSize');
            });
          });
        }

        double itemWidth = widget.itemWidth;

        return SingleChildScrollView(
          physics: scrollPhysics,
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: widget.alignment ?? CrossAxisAlignment.end,
            children: List.generate(
              _computeActualChildCount(widget.itemCount),
              (index) {
                if (index.isEven) {
                  return SizedBox(
                    width: itemWidth,
                    child: widget.children != null
                        ? widget.children![index ~/ 2]
                        : widget.itemBuilder!.call(context, index ~/ 2),
                  );
                } else {
                  return SizedBox(width: widget.crossAxisSpacing);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
