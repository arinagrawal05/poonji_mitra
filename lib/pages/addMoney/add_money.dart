import 'package:investment_zone/pages/screens.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add Money',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          amountTextField(context),
        ],
      ),
      bottomNavigationBar: addButton(context),
    );
  }

  amountTextField(context) {
    return Column(
      children: [
        Text(
          'Amount to add',
          textAlign: TextAlign.center,
          style: grey16MediumTextStyle,
        ),
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                textAlign: TextAlign.center,
                controller: TextEditingController(text: ''),
                keyboardType: TextInputType.number,
                cursorColor: primaryColor,
                style: black16SemiBoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            point(),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By continuing I agree with the',
                      style: grey12RegularTextStyle,
                    ),
                    TextSpan(
                      text: ' Disclaimer ',
                      style: primaryColor12SemiBoldTextStyle,
                    ),
                    TextSpan(
                      text: 'and',
                      style: grey12RegularTextStyle,
                    ),
                    TextSpan(
                      text: ' Terms and Conditions ',
                      style: primaryColor12SemiBoldTextStyle,
                    ),
                    TextSpan(
                      text: 'of Poonji Mitra.',
                      style: grey12RegularTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  addButton(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              currentIndex = 0;
              Navigator.push(
                context,
                PageTransition(
                  child: const RzrPage(),
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
                'ADD MONEY',
                style: white16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  point() {
    return const Text(
      '• ',
      style: TextStyle(
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
