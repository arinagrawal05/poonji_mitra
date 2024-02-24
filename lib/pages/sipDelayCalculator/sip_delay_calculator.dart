import 'package:investment_zone/pages/screens.dart';

class SIPDelayCalculator extends StatefulWidget {
  const SIPDelayCalculator({Key key}) : super(key: key);

  @override
  State<SIPDelayCalculator> createState() => _SIPDelayCalculatorState();
}

class _SIPDelayCalculatorState extends State<SIPDelayCalculator> {
  double year = 3;
  double amount = 2000;
  double rate = 20;
  double month = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'SIP Delay Calculator',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          years(),
          investment(),
          returns(),
          delay(),
          heightSpace,
          heightSpace,
          calculateButton(),
        ],
      ),
    );
  }

  years() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Investment Period (In Yr)',
                style: black16MediumTextStyle,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: greyColor.withOpacity(0.4)),
                ),
                child: Text(
                  '${year.round().toString()} Years',
                  style: black16MediumTextStyle,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 1,
          max: 10,
          value: year,
          divisions: 10,
          label: '${year.round()}',
          activeColor: primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.6),
          onChanged: (value) {
            setState(() {
              year = value;
            });
          },
        ),
      ],
    );
  }

  investment() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Investment (In Rs)',
                style: black16MediumTextStyle,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: greyColor.withOpacity(0.4)),
                ),
                child: Text(
                  'Rs. ${amount.round().toString()}',
                  style: black16MediumTextStyle,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 100,
          max: 10000,
          value: amount,
          divisions: 100,
          label: '${amount.round()}',
          activeColor: primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.6),
          onChanged: (value) {
            setState(() {
              amount = value;
            });
          },
        ),
      ],
    );
  }

  returns() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Expected Rate of Return (In %)',
                  style: black16MediumTextStyle,
                ),
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: greyColor.withOpacity(0.4)),
                ),
                child: Text(
                  '${rate.round().toString()}%',
                  style: black16MediumTextStyle,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 1,
          max: 90,
          value: rate,
          divisions: 30,
          label: '${rate.round()}',
          activeColor: primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.6),
          onChanged: (value) {
            setState(() {
              rate = value;
            });
          },
        ),
      ],
    );
  }

  delay() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delay in Starting SIP',
                style: black16MediumTextStyle,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: greyColor.withOpacity(0.4)),
                ),
                child: Text(
                  '${month.round().toString()} Months',
                  style: black16MediumTextStyle,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 1,
          max: 12,
          value: month,
          divisions: 12,
          label: '${month.round()}',
          activeColor: primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.6),
          onChanged: (value) {
            setState(() {
              month = value;
            });
          },
        ),
      ],
    );
  }

  calculateButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const SIPDelayCalculatorGraph(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 4.5,
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
              'CALCULATE',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
