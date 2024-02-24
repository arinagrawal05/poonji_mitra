import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget heightSpacer(double myHeight) => SizedBox(
      height: myHeight,
    );
Widget buildText2() {
  return Container(
    width: double.infinity,
    height: 50,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Invest In ',
            style: TextStyle(fontSize: 38.0, color: Colors.white),
          ),
          Container(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 35.0,
                color: Colors.orangeAccent,
              ),
              child: AnimatedTextKit(
                pause: new Duration(microseconds: 0),
                isRepeatingAnimation: true,
                animatedTexts: [
                  RotateAnimatedText('MF'),
                  RotateAnimatedText('Stocks'),
                  RotateAnimatedText('Bonds'),
                  RotateAnimatedText('Small Case'),
                ],
              ),
            ),
          ),
          const Text(
            '',
            style: TextStyle(fontSize: 43.0, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget buildText1() {
  return SizedBox(
    width: double.infinity,
    child: Center(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText('Want to start Investing?'),
          ],
        ),
      ),
    ),
  );
}

Widget buildBtn() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 347,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.00),
        color: Color.fromRGBO(243, 64, 161, 1),
      ),
      child: Center(
        child: Text(
          "Get Started",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.00,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

Widget buildImage() => Container(
      width: 414,
      height: 305,
      child: Lottie.asset('assets/rocket.json'),
    );

Widget buildText(String message) => Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.00,
        fontWeight: FontWeight.normal,
      ),
    );
