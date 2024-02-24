import 'package:investment_zone/pages/screens.dart';
import 'dart:math';

//import 'package:confetti/confetti.dart';

class PaymentConfirmation extends StatelessWidget {
  final String name;

  const PaymentConfirmation({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        currentIndex = 0;
        Navigator.push(
          context,
          PageTransition(
            child: const BottomBar(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              investmentInfo(name),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              backButton(context),
            ],
          ),
        ),
      ),
    );
  }

  investmentInfo(String namr) {
    return Column(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: greenColor,
          size: 90,
        ),
        heightSpace,
        heightSpace,
        Text(
          'Wohoooo Your ${name} has \nbeen created',
          style: black20SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 3),
        Text(
          'We have successfully received your\npurchase request',
          textAlign: TextAlign.center,
          style: grey14RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        // Text(
        //   'Axis Top Securities',
        //   style: black16SemiBoldTextStyle,
        // ),
        const SizedBox(height: 3),
        // RichText(
        //   text: TextSpan(
        //     children: [
        //       TextSpan(
        //         text: '• Plan - Growth ',
        //         style: grey10SemiBoldTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Equity',
        //         style: green10SemiBoldTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' • One Time Investment • Min Investment ',
        //         style: grey10SemiBoldTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Rs.1000',
        //         style: green10SemiBoldTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        heightSpace,
        heightSpace,
        heightSpace,
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 7),
              padding: const EdgeInsets.all(fixPadding * 1.5),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'We don’t have to be smarter than the rest. We have to be more disciplined than the rest',
                    textAlign: TextAlign.center,
                    style: black14SemiBoldTextStyle,
                  ),
                  Text(
                    'Investing regularly in an asset will reduce the average cost and help in accumulating more units. During a bear phase, the returns of these investments will be least affected as the average cost for the investor is lower.\n\nIn mutual funds, SIP investing helps increase financial discipline and also reduce the average cost of investing.',
                    textAlign: TextAlign.center,
                    style: grey12RegularTextStyle,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.5),
                  color: whiteColor,
                  child: Text(
                    '*',
                    style: primaryColor16BoldTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  backButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            currentIndex = 0;
            Navigator.push(
              context,
              PageTransition(
                child: const BottomBar(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 3.0,
              vertical: fixPadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              'BACK TO HOME',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
