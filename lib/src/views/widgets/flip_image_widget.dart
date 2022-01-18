import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FlipImage extends StatefulWidget {
  const FlipImage({
    required this.childCallback,
    required this.back,
    required this.front,
    required this.position,
    Key? key,
  }) : super(key: key);
  final Widget front;
  final Widget back;
  final double position;
  final Function(String child) childCallback;

  @override
  _FlipImageState createState() => _FlipImageState();
}

class _FlipImageState extends State<FlipImage> {
  double dragPosition = 0;
  bool isFront = true;
  bool isAnimated = true;
  Timer? timer;

  _transformUnion() {}

  @override
  Widget build(BuildContext context) {
    final angle = widget.position / 180 * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);
    setImageSide();
    
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: isFront
          ? widget.front
          : Transform(
              transform: Matrix4.identity()..rotateY(pi),
              alignment: Alignment.center,
              child: widget.back,
            ),
    );
  }

  void setImageSide() {
    if (widget.position <= 90 || widget.position >= 270) {
      isFront = true;
      widget.childCallback("Front");
    } else {
      isFront = false;
      widget.childCallback('Back');
    }
  }
}
