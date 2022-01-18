import 'package:flutter/material.dart';
import 'package:winorlose/src/views/screens/winorlose_home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
