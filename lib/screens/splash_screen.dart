import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.black,
      Colors.yellow,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: 'Horizon',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              child: Image.asset('assets/images/logo1.png'),
            ),
            SizedBox(height: 20,),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Bike Wali Taxi :)',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                  textAlign: TextAlign.center,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          ],
        )
      ),
    );
  }
}
