import 'package:investment_zone/pages/screens.dart';

class InvestmentCart extends StatefulWidget {
  const InvestmentCart({Key key}) : super(key: key);

  @override
  State<InvestmentCart> createState() => _InvestmentCartState();
}

class _InvestmentCartState extends State<InvestmentCart> {
  final cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Poonji Offers',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: cartList.isEmpty ? emptyList() : investmentCartList(),
    );
  }

  emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.shopping_cart_outlined,
          color: greyColor,
          size: 50,
        ),
        heightSpace,
        heightSpace,
        Center(
          child: Text(
            'Offers Comming Soon',
            style: grey16MediumTextStyle,
          ),
        ),
      ],
    );
  }

  investmentCartList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        final item = cartList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            index == 0 ? fixPadding * 2.0 : 0,
            fixPadding * 2.0,
            fixPadding * 2.0,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item['type'],
                  style: grey14MediumTextStyle,
                ),
              ),
              heightSpace,
              heightSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: item['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Text(item['title'].toString().substring(0, 1),
                        style: white14BoldTextStyle),
                  ),
                  widthSpace,
                  widthSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['title'],
                              style: black14MediumTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  cartList.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${item['title']} Remove From Cart')),
                                );
                              },
                              child: const Icon(
                                Icons.close,
                                color: greyColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Rs.${item['amount']}',
                          style: black14SemiBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              Text(
                'Amount to be paid',
                textAlign: TextAlign.center,
                style: grey16RegularTextStyle,
              ),
              heightSpace,
              Text(
                'Rs.${item['amount']}',
                style: black20BoldTextStyle,
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const PaymentMethod(),
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
                    'PAY NOW',
                    style: white16BoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
