import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:investment_zone/pages/portfolio/model.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class NewPortfolio extends StatefulWidget {
  NewPortfolio({Key key}) : super(key: key);

  @override
  State<NewPortfolio> createState() => _NewPortfolioState();
}

class _NewPortfolioState extends State<NewPortfolio> {
  var token = '';
  var investmentAccount = '';
  var mandate = '';
  InvestmentData investmentData;
  int totalHolding = 0;
  int invested = 0;
  int currentGains = 0;
  bool isDataAvailable = true;
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mandate = prefs.getString('investorMandateID');
      investmentAccount = prefs.getString('investmentAccountId');
      token = prefs.getString('token');
    });
  }

  fetchPortfolio() async {
    totalHolding = 0;
    invested = 0;
    currentGains = 0;
    await getData();

    if (investmentAccount == "0" || investmentAccount == "null") {
      setState(() {
        isDataAvailable = false;
      });
      return;
    }
    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    String url =
        'https://api.fintechprimitives.com/api/oms/investment_accounts/' +
            investmentAccount +
            '/holdings';
    print(url + " this is api url");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print("================================");
    print(response.body);
    var jsonData = jsonDecode(response.body);
    setState(() {
      investmentData = InvestmentData.fromJson(jsonData);
    });
    for (var i = 0; i < investmentData.folios.length; i++) {
      totalHolding +=
          investmentData.folios[i].schemes[0].marketValue.amount.toInt();
      invested +=
          investmentData.folios[i].schemes[0].investedValue.amount.toInt();
      currentGains = totalHolding - invested;
    }
    // investmentData = InvestmentData.fromJson(jsonData);

    print(investmentData);
    print(investmentData.folios.length.toString() + "is lenght");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object");
    fetchPortfolio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          // child: Text("data"),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Portfolio review",
                            style: white14RegularTextStyle,
                          ),
                          Text(
                            "Last imported: " + formatDateTime(DateTime.now()),
                            style: grey12RegularTextStyle,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          fetchPortfolio();
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.white30),
                isDataAvailable == true
                    ? Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Holdings",
                                style: grey12RegularTextStyle,
                              ),
                              Text(
                                totalHolding.toString() + " Rs",
                                style: white24BoldTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Invested",
                                    style: grey12RegularTextStyle,
                                  ),
                                  Text(
                                    invested.toString() + " Rs",
                                    style: white24BoldTextStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Gains",
                                    style: grey12RegularTextStyle,
                                  ),
                                  Text(
                                    currentGains.toString() + " Rs",
                                    style: white24BoldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          investmentData == null
                              ? Container(
                                  child: const Text("data"),
                                )
                              : Container(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: investmentData.folios.length,
                                    itemBuilder: (context, index) {
                                      return newa(
                                          investmentData.folios[index],
                                          investmentData
                                              .folios[index].folioNumber);
                                    },
                                  ),
                                )
                        ],
                      )
                    : Center(
                        child: Column(children: [
                        SizedBox(
                          height: 220,
                        ),
                        Text("No Details Found",
                            textAlign: TextAlign.center,
                            style: white18MediumTextStyle),
                        Text(
                            "Seems like you don't have any portfolio\nwith us.Invest now and feel\nthe difference.",
                            textAlign: TextAlign.center,
                            style: white18MediumTextStyle)
                      ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget newa(Folios folio, String folioNumber) {
  return Container(
    padding: const EdgeInsets.all(fixPadding),
    margin: const EdgeInsets.symmetric(vertical: fixPadding),
    decoration: BoxDecoration(
      color: Color(0xff273238),
      // color: whiteColor,
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
      children: [
        Text(
          folio.schemes[0].name,
          style: white22SemiBoldTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Folio No: " + folioNumber,
              style: white12MediumTextStyle,
            ),
            statusTag(folio.schemes[0].type),
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tripDown("Holding Date", folio.schemes[0].holdings.asOn),
                  tripDown("Market Date", folio.schemes[0].marketValue.asOn),
                  tripDown(
                      "Invested Date", folio.schemes[0].investedValue.asOn),
                  tripDown("Payout Date", folio.schemes[0].payout.asOn),
                  tripDown("Nav Date", folio.schemes[0].nav.asOn),
                ],
              ),
              Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tripDown("Holding Units",
                      folio.schemes[0].holdings.units.toString()),
                  tripDown("Market Value",
                      folio.schemes[0].marketValue.amount.toString()),
                  tripDown("Invested Amt",
                      folio.schemes[0].investedValue.amount.toString()),
                  tripDown(
                      "Payout Amt", folio.schemes[0].payout.amount.toString()),
                  tripDown("Nav Amt", folio.schemes[0].nav.value.toString()),
                ],
              ),
              Container()
            ],
          ),
        ),

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Overall Returns',
        //               style: grey14RegularTextStyle,
        //             ),
        //             Text(
        //               item['returns'],
        //               style: green14MediumTextStyle,
        //             ),
        //           ],
        //         ),
        //         widthSpace,
        //         widthSpace,
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Current Value',
        //               style: grey14RegularTextStyle,
        //             ),
        //             Row(
        //               children: [
        //                 Text(
        //                   item['currentValue'],
        //                   style: item['status'] == 'up'
        //                       ? green14MediumTextStyle
        //                       : red14MediumTextStyle,
        //                 ),
        //                 Icon(
        //                   item['status'] == 'up'
        //                       ? Icons.arrow_upward
        //                       : Icons.arrow_downward,
        //                   color:
        //                       item['status'] == 'up' ? greenColor : Colors.red,
        //                   size: 10,
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //     const Icon(
        //       Icons.arrow_forward_ios_rounded,
        //       color: primaryColor,
        //       size: 20,
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}

Widget statusTag(String status) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.green.shade400,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      status,
      style: white12MediumTextStyle,
    ),
  );
}

Widget tripDown(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

String formatDateTime(DateTime dateTime) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Extract day, month, and year from the DateTime object
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = months[dateTime.month - 1];
  final year = dateTime.year;

  // Concatenate the formatted string
  final formattedString = '$day $month $year';

  return formattedString;
}
