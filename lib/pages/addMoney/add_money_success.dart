import 'package:investment_zone/pages/screens.dart';

class AddMoneySuccess extends StatelessWidget {
  const AddMoneySuccess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        currentIndex = 0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              investmentInfo(),
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

  investmentInfo() {
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
          'Money sucessfully added to your Wallet!',
          style: grey14RegularTextStyle,
        ),
        heightSpace,
        Text(
          'Your Updated Wallet Balance is Rs. 4,159',
          style: primaryColor16SemiBoldTextStyle,
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
              MaterialPageRoute(builder: (context) => const BottomBar()),
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
