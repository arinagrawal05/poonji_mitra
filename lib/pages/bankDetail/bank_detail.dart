import 'package:investment_zone/pages/screens.dart';

class BankDetail extends StatelessWidget {
  final String image;
  final String name;
  final String accountNumber;
  final bool primaryBank;
  const BankDetail(
      {Key key, this.image, this.name, this.accountNumber, this.primaryBank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Bank & AutoPay',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 26,
                width: 26,
              ),
              widthSpace,
              widthSpace,
              Text(
                name,
                style: black16MediumTextStyle,
              ),
              primaryBank
                  ? Text(
                      ' (Primary bank)',
                      style: primaryColor12SemiBoldTextStyle,
                    )
                  : Container(),
            ],
          ),
          heightSpace,
          heightSpace,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Status',
                  style: grey14MediumTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 13,
                      color: primaryColor,
                    ),
                    widthSpace,
                    Text(
                      'Verified',
                      style: black14SemiBoldTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          heightSpace,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Account Number',
                  style: grey14MediumTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  accountNumber,
                  style: black14SemiBoldTextStyle,
                ),
              ),
            ],
          ),
          heightSpace,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'IFSC',
                  style: grey14MediumTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'GTDOOOO1458',
                  style: black14SemiBoldTextStyle,
                ),
              ),
            ],
          ),
          heightSpace,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Branch Name',
                  style: grey14MediumTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'SBI Bank',
                  style: black14SemiBoldTextStyle,
                ),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          heightSpace,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'AutoPay via Form',
                        textAlign: TextAlign.center,
                        style: black16MediumTextStyle,
                      ),
                    ),
                    heightSpace,
                    Text(
                      'Primary AutoPay',
                      style: grey14SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'AutoPay ID:',
                              style: grey12MediumTextStyle,
                            ),
                            Text(
                              'XXXXXX',
                              style: black12SemiBoldTextStyle,
                            ),
                          ],
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Column(
                          children: [
                            Text(
                              'Status:',
                              style: grey12MediumTextStyle,
                            ),
                            Text(
                              'Approved',
                              style: black12SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.5),
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
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          autopayButton(context),
        ],
      ),
    );
  }

  autopayButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: AutopayRequestSuccess(
                image: image,
                name: name,
                accountNumber: accountNumber,
              ),
              type: PageTransitionType.rightToLeft,
            ),
          ),
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
              'SETUP AUTOPAY',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
