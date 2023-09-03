import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);

    // Start the animation when the widget is built
    _controller?.forward();

    // After the animation completes, navigate to the next screen (e.g., home screen)
    Timer(const Duration(seconds: 4), () {
      // Replace 'HomeScreen()' with the actual widget representing your home screen.

      Navigator.pushNamed(context, "/define");
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Change to your preferred background color
      body: Center(
        child: ScaleTransition(
            scale: _animation!,
            child: Image.asset(
                "assets/images/Logo.png") // Replace with your logo widget
            ),
      ),
    );
  }
}
