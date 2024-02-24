import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';

class BankAndAutoPay extends StatelessWidget {
  BankAndAutoPay({Key key}) : super(key: key);

  final bankList = [
    {
      'image': 'assets/paymentMethod/hdfc.png',
      'name': 'XXXX Bank',
      'accountNumber': 'XXXX XXXX XXXX',
      'primaryBank': true,
    },
  ];

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
          banks(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          addButton(context),
        ],
      ),
    );
  }

  banks() {
    return ColumnBuilder(
      itemCount: bankList.length,
      itemBuilder: (context, index) {
        final item = bankList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: fixPadding),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                child: BankDetail(
                  image: item['image'],
                  name: item['name'],
                  accountNumber: item['accountNumber'],
                  primaryBank: item['primaryBank'],
                ),
                type: PageTransitionType.rightToLeft,
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item['image'],
                          height: 26,
                          width: 26,
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item['name'],
                                  style: black16MediumTextStyle,
                                ),
                                item['primaryBank']
                                    ? Text(
                                        ' (Primary Bank)',
                                        style: primaryColor12SemiBoldTextStyle,
                                      )
                                    : Container(),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['accountNumber'],
                              style: grey12MediumTextStyle,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 11,
                                  color: primaryColor,
                                ),
                                widthSpace,
                                Text(
                                  'Verified',
                                  style: grey12SemiBoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: blackColor,
                      size: 16,
                    ),
                  ],
                ),
                divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  addButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const AddAnotherBank(),
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
              'Update Bank Account',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  divider() {
    return Container(
      margin: const EdgeInsets.only(top: fixPadding),
      color: greyColor.withOpacity(0.4),
      height: 1,
      width: double.infinity,
    );
  }
}
