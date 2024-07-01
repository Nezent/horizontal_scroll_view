//SOURCE: https://stackoverflow.com/questions/60458885/how-to-autocorrect-scroll-position-in-a-listview-flutter

import 'package:flutter/material.dart';

class SnapScrollSize extends ScrollPhysics {
  const SnapScrollSize({super.parent, required this.snapSize});

  final double snapSize;

  @override
  SnapScrollSize applyTo(ScrollPhysics? ancestor) {
    return SnapScrollSize(parent: buildParent(ancestor), snapSize: snapSize);
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / snapSize;
  }

  double _getPixels(ScrollMetrics position, double page) {
    return page * snapSize;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    // ignore: deprecated_member_use
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
