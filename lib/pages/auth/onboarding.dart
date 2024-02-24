import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageViewController = PageController(initialPage: 0);
  int currentPage = 0;
  DateTime currentBackPressTime;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    getData();

    Timer.periodic(
      const Duration(seconds: 5),
      (Timer time) {
        if (currentPage < 2) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageViewController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageViewController,
                scrollDirection: Axis.horizontal,
                onPageChanged: onChanged,
                children: [
                  page1(),
                  page2(),
                  page3(),
                ],
              ),
            ),
            pageIndicator(),
          ],
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  pageIndicator() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        children: [
          SmoothPageIndicator(
            controller: pageViewController,
            count: 3,
            effect: const ExpandingDotsEffect(
              expansionFactor: 3.8,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Color.fromARGB(255, 19, 17, 17),
              activeDotColor: limeColor,
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentPage != 2
                  ? InkWell(
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child: const Signin(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: black14MediumTextStyle,
                      ),
                    )
                  : Container(),
              currentPage == 2
                  ? InkWell(
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child: const Signin(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      ),
                      child: Text(
                        'Sign in',
                        style: black16BoldTextStyle,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          currentPage++;
                        });
                        pageViewController.animateToPage(
                          currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Next',
                        style: black14MediumTextStyle,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  page1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/saving_money.png',
            height: height * 0.31,
            width: width - 20,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 130),
          Text(
            'Grow your money',
            style: black20BoldTextStyle,
          ),
          heightSpace,
          Text(
            'Compounding is the 8th wonder of the world. Smart people use it wisely',
            textAlign: TextAlign.center,
            style: black12SemiBoldTextStyle,
          ),
        ],
      ),
    );
  }

  page2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/work_portfolio.png',
            height: height * 0.31,
            width: width - 20,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 130),
          Text(
            ' Diversify your investment',
            style: black20BoldTextStyle,
          ),
          heightSpace,
          Text(
            'Concentration of asset makes you rich but diversification keeps you rich.',
            textAlign: TextAlign.center,
            style: black12SemiBoldTextStyle,
          ),
        ],
      ),
    );
  }

  page3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/investment_in_stocks.png',
            height: height * 0.31,
            width: width - 20,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 130),
          Text('You will never walk alone', style: black20BoldTextStyle),
          heightSpace,
          Text(
            'Have an investment advisor at the tap of a button throughout your investment journey.',
            textAlign: TextAlign.center,
            style: black12SemiBoldTextStyle,
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('name') != null &&
        prefs.getString('email') != null &&
        prefs.getString('mobile') != null) {
      Navigator.push(
          context,
          PageTransition(
              child: const BottomBar(), type: PageTransitionType.rightToLeft));
    }
  }
}
