import 'package:investment_zone/pages/screens.dart';

class AutopayRequestSuccess extends StatelessWidget {
  final String image;
  final String name;
  final String accountNumber;
  const AutopayRequestSuccess(
      {Key key, this.image, this.name, this.accountNumber})
      : super(key: key);

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            autoPayInfo(),
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
    );
  }

  autoPayInfo() {
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
          'Great!',
          style: black20SemiBoldTextStyle,
        ),
        const SizedBox(height: 3),
        Text(
          'Your AutoPay request has been submitted\nsuccessfully',
          textAlign: TextAlign.center,
          style: grey14RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 20,
              width: 20,
            ),
            widthSpace,
            widthSpace,
            Text(
              name,
              style: black16SemiBoldTextStyle,
            ),
            Text(
              ' ($accountNumber)',
              style: grey12MediumTextStyle,
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        Text(
          'Expected completion time.',
          style: grey14RegularTextStyle,
        ),
        Text(
          '2-7 working days.',
          style: black14SemiBoldTextStyle,
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
