import 'package:investment_zone/pages/screens.dart';

class PortfolioStocks extends StatelessWidget {
  PortfolioStocks({Key key}) : super(key: key);

  final stockList = [
    {
      'color': indigoColor,
      'title': 'BNI-AM Indeks IDX30',
      'investment': 'Rs.1,000.00',
      'currentValue': 'Rs.0.00',
      'returns': 'Rs.0.00',
    },
    {
      'color': purpleColor,
      'title': 'Hoeizon First Fund Direct Plan Growth',
      'investment': 'Rs.2,000.00',
      'currentValue': 'Rs.1,592.59',
      'returns': '-Rs.0.04',
    },
    {
      'color': cyanColor,
      'title': 'Sun Bank Direct Plan Growth',
      'investment': 'Rs.1,000.00',
      'currentValue': 'Rs.0.00',
      'returns': 'Rs.0.00',
    },
    {
      'color': greenColor,
      'title': 'HDFC Securities',
      'investment': 'Rs.2,000.00',
      'currentValue': 'Rs.1,592.59',
      'returns': '-Rs.0.04',
    },
    {
      'color': blueColor,
      'title': 'TATA Index Fund',
      'investment': 'Rs.1,000.00',
      'currentValue': 'Rs.0.00',
      'returns': 'Rs.0.00',
    },
    {
      'color': redColor,
      'title': 'Axis Top Securities',
      'investment': 'Rs.2000.00',
      'currentValue': 'Rs.1,592.59',
      'returns': '-Rs.0.04',
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
          'Stocks',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: stocks(),
    );
  }

  stocks() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: stockList.length,
      itemBuilder: (context, index) {
        final item = stockList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            fixPadding * 1.5,
            fixPadding * 2.0,
            0,
          ),
          child: Container(
            padding: const EdgeInsets.all(fixPadding),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      child: Text(
                        item['title'],
                        style: black14MediumTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Min Investment',
                          style: grey12RegularTextStyle,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['investment'],
                          style: green14BoldTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'CurrentValue',
                          style: grey12RegularTextStyle,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['currentValue'],
                          style: green14BoldTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Returns',
                          style: grey12RegularTextStyle,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['returns'],
                          style: red14BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
