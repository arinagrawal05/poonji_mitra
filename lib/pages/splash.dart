import 'dart:async';
import 'dart:io';

import 'package:investment_zone/pages/screens.dart';

import '../widget/widgets.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        PageTransition(
          child: const Onboarding(),
          type: PageTransitionType.rightToLeft,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        // backgroundColor: Colors.grey.shade200,
        // backgroundColor: Color.fromRGBO(155, 34, 228, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
              ),
              Image.asset(
                "assets/logo.png",
                height: 250,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    imageLogo("assets/pci.png"),
                    imageLogo("assets/startupindia.png"),
                    imageLogo("assets/amfi.jpg"),
                  ],
                ),
              ),
              Image.asset(
                "assets/builtindia.jpg",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 50,
              ),
              // buildImage(),
              // heightSpacer(25.00),
              // buildText1(),
              // heightSpacer(25.00),
              // buildText2(),
              // buildText("with Poonji Mitra"),
              // heightSpacer(69.00),
              // buildBtn(),
            ],
          ),
        ),
      ),
      //  child: Scaffold(
      //   backgroundColor: whiteColor,
      //   body: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Center(
      //         child: Image.asset(
      //           'assets/Splash.gif',
      //           fit: BoxFit.fitHeight,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget imageLogo(String url) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Image.asset(url));
  }
}
