import 'dart:math';

import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  final Widget child;
  const Spinner({super.key, required this.child});
  @override
  SpinnerState createState() => SpinnerState();
}

class SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * pi,
          child: child!,
        );
      },
    );
  }
}
