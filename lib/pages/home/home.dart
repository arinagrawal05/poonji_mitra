import 'dart:convert';

import 'package:investment_zone/pages/ipo/ipo.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '../bonds/bondsCat.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var new_fundList = [];
  var name = '';
  var mobile = '';
  var email = '';
  bool showOnboardingCard = false;
  bool newShowBoardingCard = false;
  bool investorID = false;
  bool investmentAccount = false;

  bool hasInvestorID = false;
  bool hasMandate = false;

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile').substring(3);
    await getFundsList();
    bool containsInvestorID =
        prefs.containsKey('isOnboardingComplete') ? true : false;

    bool containsInvestmentAccount =
        prefs.containsKey('investmentAccountID') ? true : false;

    hasInvestorID = prefs.getString('investorId') == 'true';
    hasMandate = prefs.getString('mandateId') == 'true';

    if (prefs.getString('token') == "" || prefs.getString('token') == null) {
      var token = await getToken();
      await prefs.setString('token', token);
    }
    var investmentAccountId = prefs.getString('investmentAccountId');
    var bankAccountId = prefs.getString('bankAccountId');
    var mandateId = prefs.getString('mandateId');
    var investorId = prefs.getString('investorId');
    setState(() {
      if (bankAccountId == null ||
          bankAccountId == "null" ||
          bankAccountId == "" ||
          bankAccountId == "0" ||
          mandateId == null ||
          mandateId == "null" ||
          mandateId == "" ||
          mandateId == "0" ||
          investmentAccountId == null ||
          investmentAccountId == "null" ||
          investmentAccountId == "" ||
          investmentAccountId == "0" ||
          investorId == null ||
          investorId == "null" ||
          investorId == "" ||
          investorId == "0") {
        newShowBoardingCard = true;
        //  =
        //     prefs.setString('isOnboardingComplete') ? false : true;
      } else {
        newShowBoardingCard = false;
      }
      showOnboardingCard =
          prefs.containsKey('isOnboardingComplete') ? false : true;

      if (containsInvestorID || containsInvestmentAccount) {
        showOnboardingCard = false;
      }
    });
  }

  double height;

  final featuresList = [
    {
      'image': 'assets/fund.png',
      'title': 'Bonds',
      'page': BondCat(),
    },
    {
      'image': 'assets/raise.png',
      'title': 'IPO',
      'page': const Ipo(),
    },
    {
      'image': 'assets/sharing.png',
      'title': 'Small Case',
      'page': const Smallcase(),
    },
    {
      'image': 'assets/clipboard.png',
      'title': 'Insurance',
    },
  ];

  final categoryList = [
    {
      'image': 'assets/category/category1.png',
      'category': 'High Return',
    },
    {
      'image': 'assets/category/category2.png',
      'category': 'Tax Saving',
    },
    {
      'image': 'assets/category/category3.png',
      'category': 'Top Companies',
    },
    {
      'image': 'assets/category/category4.png',
      'category': 'Low Risk',
    },
    {
      'image': 'assets/category/category5.png',
      'category': 'Worth rs.500',
    },
    {
      'image': 'assets/category/category6.png',
      'category': 'Better than FD',
    },
    {
      'image': 'assets/category/category7.png',
      'category': 'Equity Funds',
    },
    {
      'image': 'assets/category/category8.png',
      'category': 'Debt Funds',
    },
    {
      'image': 'assets/category/category9.png',
      'category': 'Balanced',
    },
    {
      'image': 'assets/category/category9.png',
      'category': 'Invest In Gold',
    },
    {
      'image': 'assets/category/category9.png',
      'category': 'Invest Abroad',
    },
  ];

  final fundsList = [
    {
      'color': redColor,
      'title': 'DSP Small Cap Fund',
      'rating': 5,
      'investment': 'Rs.500',
      'category': 'Equity',
      'returns': '+23.01%',
      'isin': 'INF740K01797'
    },
    {
      'color': purpleColor,
      'title': 'ABSL SMall Cap Fund',
      'rating': 4,
      'investment': 'Rs.1000',
      'category': 'Equity',
      'returns': '+12.24%',
      'isin': 'INF209K01EN2'
    },
    {
      'color': indigoColor,
      'title': 'Kotak Small Cap Fund',
      'rating': 3,
      'investment': 'Rs.5,000',
      'category': 'Equity',
      'returns': '+28.06%',
      'isin': 'INF174K01211'
    },
    {
      'color': indigoColor,
      'title': 'SBI Small Cap Fund',
      'rating': 3,
      'investment': 'Rs.5,000',
      'category': 'Equity',
      'returns': '+24.45%',
      'isin': 'INF200K01T28'
    },
    {
      'color': indigoColor,
      'title': 'Nippon SmallCap Fund ',
      'rating': 3,
      'investment': 'Rs.5,000',
      'category': 'Equity',
      'returns': '+26.39%',
      'isin': 'INF204K01HY3'
    },
    {
      'color': indigoColor,
      'title': 'DSP Global Alloction Fund',
      'rating': 3,
      'investment': 'Rs.500',
      'category': 'Equity',
      'returns': '+7.93%',
      'isin': 'INF740K01Z27'
    },
    {
      'color': indigoColor,
      'title': 'Aditya Birla Sun Life International Equity Fun',
      'rating': 3,
      'investment': 'Rs.1,000',
      'category': 'Equity',
      'returns': '+8.47%',
      'isin': 'INF209K01520'
    },
    {
      'color': indigoColor,
      'title': 'Kotak pioneer fund ',
      'rating': 3,
      'investment': 'Rs.5,000',
      'category': 'Equity',
      'returns': '+28.06%',
      'isin': 'INF174KA1EW8'
    },
    {
      'color': indigoColor,
      'title': 'SBI International Equity US Acess FOF',
      'rating': 3,
      'investment': 'Rs.5,000',
      'category': 'Equity',
      'returns': '+28.06%',
      'isin': 'INF200KA1T96'
    },
    {
      'color': indigoColor,
      'title': 'Nippon US India opportunity fund',
      'rating': 3,
      'investment': 'Rs. 100',
      'category': 'Equity',
      'returns': '+10.62%',
      'isin': 'INF204KA12G2'
    },
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shadowColor: Colors.grey,
        elevation: 4,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace,
            heightSpace,
            heightSpace,
            Text(
              'Hey $name',
              style: white22SemiBoldTextStyle,
            ),
            Text(
              'Today is a good day to start',
              style: white14RegularTextStyle,
            ),
            heightSpace,
            heightSpace,
            heightSpace,
          ],
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/users/user.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              widthSpace,
            ],
          ),
        ],
      ),
      body: Container(
        // color: Col,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            banner(context),
            newShowBoardingCard
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const Pan(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: completeOnboarding(),
                  )
                : Container(),
            //   completeOnboarding(),
            features(),
            category(),
            funds(),
          ],
        ),
      ),
    );
  }

  banner(context) {
    return Container(
      height: height * 0.25,
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
      child: PageView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          bannerImage("assets/Bonds.png"),
          bannerImage("assets/IPOS.png"),
          bannerImage("assets/MutualFunds.png"),
          bannerImage("assets/SmallCase.png"),
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //   padding: const EdgeInsets.fromLTRB(
          //     fixPadding,
          //     fixPadding,
          //     fixPadding * 4.0,
          //     fixPadding,
          //   ),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     gradient: const LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [primaryColor, limeColor],
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         'assets/banner/image1.png',
          //         height: 80,
          //         width: 55,
          //       ),
          //       widthSpace,
          //       widthSpace,
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text: 'Make investing a habit\nwith ',
          //                   style: white18MediumTextStyle,
          //                 ),
          //                 TextSpan(
          //                   text: 'SIPs',
          //                   style: lime18BoldTextStyle,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           heightSpace,
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text: 'Start your journey with as little as',
          //                   style: white12MediumTextStyle,
          //                 ),
          //                 TextSpan(
          //                   text: '\nRs.500 per month',
          //                   style: lime12BoldTextStyle,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           heightSpace,
          //           heightSpace,
          //           InkWell(
          //             borderRadius: BorderRadius.circular(15),
          //             onTap: () => Navigator.push(
          //               context,
          //               PageTransition(
          //                 child: const Invest(),
          //                 type: PageTransitionType.rightToLeft,
          //               ),
          //             ),
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(
          //                 horizontal: fixPadding * 1.7,
          //                 vertical: 8,
          //               ),
          //               decoration: BoxDecoration(
          //                 color: whiteColor,
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               child: Text(
          //                 'Invest Now',
          //                 style: primaryColor12BoldTextStyle,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(right: fixPadding * 2.0),
          //   padding: const EdgeInsets.fromLTRB(
          //     fixPadding,
          //     fixPadding,
          //     fixPadding * 4.0,
          //     fixPadding,
          //   ),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     gradient: const LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [primaryColor, limeColor],
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         'assets/banner/image2.png',
          //         height: 80,
          //         width: 80,
          //       ),
          //       widthSpace,
          //       widthSpace,
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text: 'Beat the inflation & \n',
          //                   style: white18MediumTextStyle,
          //                 ),
          //                 TextSpan(
          //                   text: 'Earn higher returns',
          //                   style: lime18BoldTextStyle,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           heightSpace,
          //           RichText(
          //             text: TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text: 'Start your journey with as little as',
          //                   style: white12MediumTextStyle,
          //                 ),
          //                 TextSpan(
          //                   text: '\nEquity mutual funds',
          //                   style: lime12BoldTextStyle,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           heightSpace,
          //           heightSpace,
          //           InkWell(
          //             borderRadius: BorderRadius.circular(15),
          //             onTap: () => Navigator.push(
          //               context,
          //               PageTransition(
          //                 child: const Invest(),
          //                 type: PageTransitionType.rightToLeft,
          //               ),
          //             ),
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(
          //                 horizontal: fixPadding * 1.7,
          //                 vertical: 8,
          //               ),
          //               decoration: BoxDecoration(
          //                 color: whiteColor,
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               child: Text(
          //                 'Invest Now',
          //                 style: primaryColor12BoldTextStyle,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Image bannerImage(String imageUrl) {
    return Image.asset(imageUrl);
  }

  completeOnboarding() {
    return Container(
      height: height * 0.10,
      // color: greyColor,

      margin: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, 0, fixPadding * 2.0, fixPadding * 2.0),
      padding: const EdgeInsets.fromLTRB(
          fixPadding, fixPadding, fixPadding, fixPadding),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffF5A292), Color(0xffF8D869)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/shoppinglist.png',
            height: 45,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Complete your',
                style: white14BoldTextStyle,
              ),
              widthSpace,
              widthSpace,
              Text(
                'Onboarding',
                style: white14BoldTextStyle,
              )
            ],
          ),
        ],
      ),
    );
  }

  features() {
    return SizedBox(
        height: height * 0.13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) {
              final item = featuresList[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? fixPadding * 2.0 : fixPadding * 0.8,
                  0,
                  fixPadding * 1.0,
                  0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (index == 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Feature coming Soon!!'),
                        ),
                      );
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: item['page'],
                              type: PageTransitionType.rightToLeft));
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(fixPadding * 1.5),
                        decoration: BoxDecoration(
                          color: Color(0xffF3A195),
                          // shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          item['image'],
                          height: 35,
                          width: 35,
                          // color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['title'],
                        style: white12MediumTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )

        // ListView.builder(
        //   physics: const BouncingScrollPhysics(),
        //   scrollDirection: Axis.horizontal,
        //   itemCount: featuresList.length,
        //   itemBuilder: (context, index) {
        //     final item = featuresList[index];
        //     return Padding(
        //       padding: EdgeInsets.fromLTRB(
        //         index == 0 ? fixPadding * 2.0 : fixPadding * 0.8,
        //         0,
        //         fixPadding * 1.0,
        //         0,
        //       ),
        //       child: GestureDetector(
        //         onTap: () {
        //           if (index == 3) {
        //             ScaffoldMessenger.of(context).showSnackBar(
        //               SnackBar(
        //                 content: const Text('Feature coming Soon!!'),
        //               ),
        //             );
        //           } else {
        //             Navigator.push(
        //                 context,
        //                 PageTransition(
        //                     child: item['page'],
        //                     type: PageTransitionType.rightToLeft));
        //           }
        //         },
        //         child: Column(
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.all(fixPadding * 1.5),
        //               decoration: BoxDecoration(
        //                 color: Color(0xffF3A195),
        //                 // shape: BoxShape.rectangle,
        //                 borderRadius: BorderRadius.circular(6),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: primaryColor.withOpacity(0.2),
        //                     spreadRadius: 2,
        //                     blurRadius: 2,
        //                   ),
        //                 ],
        //               ),
        //               child: Image.network(
        //                 item['image'],
        //                 height: 35,
        //                 width: 35,
        //                 // color: whiteColor,
        //               ),
        //             ),
        //             const SizedBox(height: 5),
        //             Text(
        //               item['title'],
        //               style: white12MediumTextStyle,
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        );
  }

  category() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: white16BoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 100,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final item = categoryList[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: Category(category: item['category']),
                    type: PageTransitionType.rightToLeft,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(fixPadding * 2.0),
                        child: Image.asset(
                          item['image'],
                          height: 40,
                          width: 40,
                        ),
                      ),
                      divider(),
                      Text(
                        item['category'],
                        style: white12MediumTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  funds() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Poonji Suggested - With Best Returns',
            style: white16BoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          ColumnBuilder(
            // itemCount: fundsList.length,
            itemCount: new_fundList.length,
            itemBuilder: (context, index) {
              final item = new_fundList[index];
              //final item = fundsList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: fixPadding * 1.5),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: FundDetail(
                          color: indigoColor,
                          title: item['fundName'],
                          rating: 5,
                          investment: 'Rs ' + item['minimumSIP'],
                          category: item['nav'],
                          returns: item['fiveYearCAGR'],
                          isin: item['isin'],
                          jsonString: jsonEncode(item).toString()),
                      type: PageTransitionType.rightToLeft,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(fixPadding),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Colors.grey),
                      color: blackColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: greyColor.withOpacity(0.9),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                            offset: Offset(1, 1)),
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
                                color: Colors.indigo,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                  item['fundName'].toString().substring(0, 1),
                                  style: white14BoldTextStyle),
                            ),
                            widthSpace,
                            widthSpace,
                            Expanded(
                              child: Text(
                                item['fundName'],
                                style: white14RegularTextStyle,
                              ),
                            ),
                            ratingStars(5),
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
                                  'Rs ' + item['minimumSIP'],
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Nav',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['nav'],
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Returns 5Y',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['fiveYearCAGR'],
                                  style: red14BoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ratingStars(int rating) {
    return Row(
      children: [
        if (rating == 5 ||
            rating == 4 ||
            rating == 3 ||
            rating == 2 ||
            rating == 1)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4 || rating == 3 || rating == 2)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4 || rating == 3)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
      ],
    );
  }

  divider() {
    return Container(
      color: greyColor.withOpacity(0.4),
      height: 1,
      width: double.infinity,
    );
  }

  Future<void> getFundsList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http.get(
        Uri.parse('http://api.poonjimitra.com/api/fund'),
        headers: headers);
    var jsonData = jsonDecode(response.body);
    new_fundList = await jsonData;
  }

  Future<String> getToken() async {
    var body = {"isProduction": "1"};

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse('http://api.poonjimitra.com/api/token'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);

    if (jsonData["token"] != null) {
      return jsonData["token"].toString();
    }
    return '0';
  }
}
