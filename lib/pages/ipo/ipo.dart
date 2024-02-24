import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:investment_zone/constants/constants.dart';
import 'package:investment_zone/pages/ipo/ipoInvest.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slimy_card/slimy_card.dart';
import '../../components/easyCard.dart';
import '../../widget/column_builder.dart';
import '../fundDetail/fund_detail.dart';
import 'package:http/http.dart' as http;

class Ipo extends StatefulWidget {
  const Ipo({Key key}) : super(key: key);

  @override
  State<Ipo> createState() => _IpoState();
}

class _IpoState extends State<Ipo> {
  @override
  void initState() {
    super.initState();

    setState(() {
      getData();
    });
  }

  var new_fundList = [];
  var name = '';
  var mobile = '';
  var email = '';
  double height;

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile').substring(3);
    await getFundsList();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'IPO',
          style: white18MediumTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            margin: const EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              0,
              fixPadding * 2.0,
              fixPadding * 2.0,
            ),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: whiteColor.withOpacity(0.1),
                  spreadRadius: 1.5,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: TextField(
              cursorColor: primaryColor,
              style: white16BoldTextStyle,
              decoration: InputDecoration(
                hintText: 'Search here',
                hintStyle: grey16RegularTextStyle,
                prefixIcon: const Icon(
                  Icons.search,
                  color: greyColor,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  // onPressed: () => bottomsheet(context),
                  icon: const Icon(
                    Icons.filter_alt_rounded,
                    color: greyColor,
                    size: 15,
                  ),
                ),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          funds(),
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
                      child: IpoInvest(
                        //color: indigoColor,
                        whyToInvest: item['sector'],
                        ipoName: item['ipoName'],
                        openingDate: item['openDate'],
                        closingDate: item['closedDate'],
                        listingDate: item['listingDate'],
                        marketLot: item['lotSize'],
                        price: item['priceBand'],
                        listing: item['listedOn'],
                        // jsonString: jsonEncode(item).toString())
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(fixPadding),
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: whiteColor.withOpacity(0.1),
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
                                color: Colors.indigo,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                  item['ipoName'].toString().substring(0, 1),
                                  style: white14BoldTextStyle),
                            ),
                            widthSpace,
                            widthSpace,
                            Expanded(
                              child: Text(
                                item['ipoName'],
                                style: white14RegularTextStyle,
                              ),
                            ),
                            // ratingStars(5),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Open Date',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['openDate'],
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Close Date',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['closedDate'],
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Allotment Date',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['allotmentDate'],
                                  style: red14BoldTextStyle,
                                ),
                              ],
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
                                  'Listing Date',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['listingDate'],
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Refund Date',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['refundDate'].toString(),
                                  style: green14BoldTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Listed On',
                                  style: grey12RegularTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item['listedOn'].toString(),
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

  Future<void> getFundsList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http
        .get(Uri.parse('http://api.poonjimitra.com/api/ipo'), headers: headers);
    var jsonData = jsonDecode(response.body);
    new_fundList = await jsonData;
    setState(() {});
  }
}
