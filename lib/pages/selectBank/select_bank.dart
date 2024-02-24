import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({Key key}) : super(key: key);

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  String isSelected = 'HDFC';

  final bankTransferList = [
    {
      'image': 'assets/paymentMethod/sbi.png',
      'method': 'SBI',
    },
    {
      'image': 'assets/paymentMethod/hdfc.png',
      'method': 'HDFC',
    },
    {
      'image': 'assets/paymentMethod/bob.png',
      'method': 'BOB',
    },
    {
      'image': 'assets/paymentMethod/icic.png',
      'method': 'ICIC',
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
          'Payment Method',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          bankTransfer(),
          heightSpace,
          heightSpace,
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

  bankTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Bank',
          style: black16SemiBoldTextStyle,
        ),
        ColumnBuilder(
          itemCount: bankTransferList.length,
          itemBuilder: (context, index) {
            final item = bankTransferList[index];
            return Padding(
              padding: const EdgeInsets.only(top: fixPadding),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = item['method'];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.1),
                        spreadRadius: 1.5,
                        blurRadius: 1.5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            item['image'],
                            height: 21,
                            width: 26,
                          ),
                          widthSpace,
                          widthSpace,
                          Text(
                            item['method'],
                            style: black14MediumTextStyle,
                          ),
                        ],
                      ),
                      Container(
                        height: 16,
                        width: 16,
                        padding: const EdgeInsets.all(fixPadding / 3.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: isSelected == item['method']
                                  ? primaryColor
                                  : greyColor.withOpacity(0.4)),
                        ),
                        child: isSelected == item['method']
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
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
              child: const AddMoneySuccess(),
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
              'ADD MONEY',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
