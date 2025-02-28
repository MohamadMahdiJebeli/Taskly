import 'package:flutter/material.dart';
import 'package:taskly/gen/assets.gen.dart';
import 'package:taskly/main_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoOpacity = 0.0;
  double _textPosition = -1.0; // Corrected alignment range (-1 to 1)

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoOpacity = 1.0;
        _textPosition = 0.0;
      });
    });
    
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF694D88), // Fixed color format
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AnimatedOpacity(
                //   duration: const Duration(seconds: 1),
                //   opacity: _logoOpacity,
                //   child: Image.asset(Assets.taskly.path)
                // ),
                const SizedBox(height: 20),
                AnimatedAlign(
                  duration: const Duration(seconds: 1),
                  alignment: Alignment(0, _textPosition),
                  child: const Text(
                    "Taskly",
                    style: TextStyle(
                      fontSize: 32, // Increased font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0, // Added letter spacing
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 50,
          //   left: 0,
          //   right: 0,
          //   child: Column(
          //       children: [
          //         const Text("Developed by",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w300),),
          //         SizedBox(height: 20,),
          //         Image.asset(Assets.mJ21NoBg.path,),
          //       ],
          //     ))
        ],
      ),
    );
  }
}