import 'dart:convert';

import 'package:investment_zone/pages/bonds/bondsList.dart';
import 'package:investment_zone/pages/ipo/ipo.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class BondCat extends StatefulWidget {
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<BondCat> {
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
  bool investorID = false;
  bool investmentAccount = false;

  bool hasInvestorID = false;
  bool hasMandate = false;

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile').substring(3);
    // await getFundsList();
    bool containsInvestorID =
        prefs.containsKey('isOnboardingComplete') ? true : false;

    bool containsInvestmentAccount =
        prefs.containsKey('investmentAccountID') ? true : false;

    hasInvestorID = prefs.getString('investorId') == 'true';
    hasMandate = prefs.getString('mandateId') == 'true';

    setState(() {
      showOnboardingCard =
          prefs.containsKey('isOnboardingComplete') ? false : true;

      if (containsInvestorID || containsInvestmentAccount) {
        showOnboardingCard = false;
      }
    });
  }

  double height;

  final categoryList = [
    {
      'image': 'assets/icons/aaa.png',
      'category': 'AAA Rated Bonds',
      'id': '1',
    },
    {
      'image': 'assets/icons/psu.png',
      'category': 'PSU Bonds',
      'id': '2',
    },
    {
      'image': 'assets/icons/stgov.png',
      'category': 'State Govt Bonds',
      'id': '3',
    },
    {
      'image': 'assets/icons/month.png',
      'category': 'Monthly Coupon Bonds',
      'id': '4',
    },
    {
      'image': 'assets/icons/perp.png',
      'category': 'Perpetual Bonds',
      'id': '5',
    },
    {
      'image': 'assets/icons/bankb.png',
      'category': 'Bank Bonds',
      'id': '6',
    },
    {
      'image': 'assets/icons/bondss.png',
      'category': 'NBFC Bonds',
      'id': '7',
    },
    {
      'image': 'assets/category/category8.png',
      'category': 'Non PSU',
      'id': '8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Bond Categories ',
          style: white18MediumTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          category(),
        ],
      ),
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
            'Explore bonds',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
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
                    child: BondList(category: item['id']),
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
}
