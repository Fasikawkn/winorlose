import 'package:flutter/material.dart';
import 'package:winorlose/src/views/screens/winorlose_home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
           image: DecorationImage(
             image: AssetImage( 'assets/images/splash.png',),
            fit: BoxFit.fill,
            )
           )
          ),
         
        
      ),
    );
  }
}
