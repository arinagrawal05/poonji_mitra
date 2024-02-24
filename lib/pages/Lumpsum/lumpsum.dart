import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class Lumpsum extends StatefulWidget {
  final Color color;
  final String title;
  final String plan;
  final String type;
  final String isin;
  const Lumpsum(
      {Key key,
      this.title = 'LUMPSUM',
      this.plan = 'Growth',
      this.type = 'One Time',
      this.color = redColor,
      this.isin})
      : super(key: key);

  @override
  State<Lumpsum> createState() => _InvestState();
}

class _InvestState extends State<Lumpsum> {
  double width;
  String selectedDate = '5';

  var token = '';
  var investmentAccount = '';
  var mandate = '';

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    mandate = prefs.getString('investorMandateID');
    investmentAccount = prefs.getString('investmentAccountId');
    token = prefs.getString('token');
  }

  final investmentAmount = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
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
          widget.title,
          style: white18BoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          detail(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              investButton(),
              //cartButton(),
            ],
          ),
        ],
      ),
    );
  }

  detail() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
              child: Text(widget.title.toString().substring(0, 1),
                  style: white14BoldTextStyle),
            ),
            widthSpace,
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: white14RegularTextStyle,
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Plan - ${widget.plan} ',
                          style: orignalgrey14RegularTextStyle,
                        ),
                        TextSpan(
                          text: '${widget.type} Investment',
                          style: green14BoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
        Text(
          'Investment Amount (Rs)',
          textAlign: TextAlign.center,
          style: grey16RegularTextStyle,
        ),
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 3,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                cursorColor: whiteColor,
                controller: investmentAmount,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        Text(
          'Min Invest Rs.1000',
          textAlign: TextAlign.center,
          style: white14RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
        divider(),
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          children: [
            point(),
            Text(
              'This fund allow SIP',
              style: white12MediumTextStyle,
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            point(),
            Expanded(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing I agree with the ',
                          style: grey12RegularTextStyle,
                        ),
                        TextSpan(
                          text: 'Disclaimer',
                          style: white12MediumTextStyle,
                        ),
                        TextSpan(
                          text: ' and ',
                          style: grey12RegularTextStyle,
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: white12MediumTextStyle,
                        ),
                        TextSpan(
                          text: ' of Poonji Mitra.',
                          style: grey12RegularTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  dateDialog() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked.toString().substring(8, 10);
      });
    }
  }

  point() {
    return const Text(
      '• ',
      style: TextStyle(
        color: whiteColor,
        fontSize: 12,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: fixPadding / 2),
      color: greyColor.withOpacity(0.4),
      height: 1,
      width: double.infinity,
    );
  }

  investButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        currentIndex = 0;
        // setState(() {
        //   _isLoading = true;
        // });
        String id = await createLumpsum();
        if (id != null) {
          Navigator.push(
            context,
            PageTransition(
              child: const PaymentConfirmation(name: "LUMPSUM"),
              type: PageTransitionType.rightToLeft,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            // ignore: prefer_const_constructors
            SnackBar(
              content: const Text(
                  'There is some technical issue. Please Contact Customer care'),
            ),
          );
          // Fluttertoast.showToast(
          //   msg: 'You are not KYC Compliant. Please complete your KYC',
          //   backgroundColor: blackColor,
          //   textColor: whiteColor,
          // );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 10,
          vertical: fixPadding * 1.5,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: whiteColor.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          'INVEST NOW',
          style: black16SemiBoldTextStyle,
        ),
      ),
    );
  }

  cartButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: const InvestmentCart(),
          type: PageTransitionType.rightToLeft,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.7,
          vertical: fixPadding * 1.5,
        ),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: whiteColor.withOpacity(0.1),
              blurRadius: 1.5,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Text(
          'ADD TO CART',
          style: primaryColor16BoldTextStyle,
        ),
      ),
    );
  }

  // API Payment URL

  Future<String> createPaymentLink(id) async {
    var body = {
      "amc_order_ids": [id],
      "payment_postback_url": "https://poonjimitra.com/lumpsumpayment.html"
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse(
            'https://api.fintechprimitives.com/api/pg/payments/netbanking'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);

    if (jsonData['token_url'] != null) {
      return jsonData['token_url'];
    }

    return 'FALSE';
  }

  //Create Lumpsun

  Future<String> createLumpsum() async {
    await getData();

    var body = {
      "mf_investment_account": investmentAccount,
      // "old_id": 56,
      "scheme": widget.isin,
      "amount": investmentAmount.text
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse('https://api.fintechprimitives.com/v2/mf_purchases'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);

    if (jsonData['id'] != null) {
      var url = await createPaymentLink(jsonData['id']);

      _launchURL(url);
    }
    return 'FALSE';
  }

  //Launch URL

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
