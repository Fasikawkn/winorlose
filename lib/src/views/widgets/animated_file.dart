import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({Key? key}) : super(key: key);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late String _currentImage;
  late String _image2;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          debugPrint("Completed");

          _controller.repeat(reverse: false);
          // _controller.forward(
          //   from: 0.0
          // );
          _controller.value = pi / 2;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedImage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final angle = pi * _controller.value;
    debugPrint("THe angle is $angle");

    return GestureDetector(
      onTap: () {
        _controller.reverse(
          from: 1.0,
        );

        // _controller.isCompleted
      },
      onDoubleTap: () {
        _controller.stop();
      },
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            final rotation = pi * _controller.value;

            return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotation),
                alignment: FractionalOffset.center,
                child: setImageSide(rotation));
          },
          // child: SvgPicture.asset(
          //   'assets/images/Frame5.svg',
          //   width: 200,
          // ),
        ),
      ),
    );
  }

  Widget setImageSide(double rotation) {
    if (rotation <= pi / 2) {
      return SvgPicture.asset(
        'assets/images/Frame5.svg',
        width: 200,
      );
    } else {
      return SvgPicture.asset(
        'assets/images/Frame6.svg',
        width: 200,
      );
    }
  }
}
