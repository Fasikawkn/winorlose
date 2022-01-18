import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatefulWidget {
  CardWidget({
    required this.childCallBack,
  });
  final Function(bool isFront) childCallBack;
  @override
  createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late Widget cardFront;
  late Widget cardBack;
  bool showFront = true;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    cardFront = SvgPicture.asset(
      "assets/images/Frame5.svg",
      width: 200.0,
    );
    cardBack = SvgPicture.asset(
      "assets/images/Frame6.svg",
      width: 200.0,
    );

    // Initialize the animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
    );
    _setTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // precacheImage(cardFront.image, context);
    // precacheImage(cardBack.image, context);
  }

  Timer? _timer;
  _setTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) async {
      await controller.forward();
      setState(() => showFront = !showFront);
      await controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _timer!.cancel();
        widget.childCallBack(showFront);
      },
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.rotationY((controller.value) * pi / 2),
              alignment: Alignment.center,
              child: showFront ? cardFront : cardBack,
            );
          },
        ),
      ),
    );
  }
}


// TextButton(
//           child: const Text("flip me"),
//           onPressed: () {
//             // Flip the image
//             _timer = Timer.periodic(const Duration(milliseconds: 600),
//                 (timer) async {
//               await controller.forward();
//               setState(() => showFront = !showFront);
//               await controller.reverse();
//             });
//           },
//         ),