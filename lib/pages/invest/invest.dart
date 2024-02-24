import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class Invest extends StatefulWidget {
  final Color color;
  final String title;
  final String plan;
  final String type;
  final String isin;
  const Invest(
      {Key key,
      this.title,
      this.plan = 'Growth',
      this.type = 'One Time',
      this.color = redColor,
      this.isin})
      : super(key: key);

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  double width;
  String selectedDate = '5';

  var token = '';
  var investmentAccount = '';
  var mandate = '';
  var bankAccountId = '';

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    mandate = prefs.getString('investorMandateID');
    investmentAccount = prefs.getString('pan');
    var tokenvalue = await UpdateToken();
    token = tokenvalue;
    bankAccountId = prefs.getString('bankAccountId');
  }

  final investmentAmount = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
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
                          style: white14RegularTextStyle,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => dateDialog(),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/calendar.png',
                    height: 15,
                    width: 15,
                    color: Colors.white,
                  ),
                  widthSpace,
                  Text(
                    'SIP Date',
                    style: white14RegularTextStyle,
                  ),
                ],
              ),
            ),
            Text(
              '${selectedDate.toString()} date of every month',
              style: white14RegularTextStyle,
            ),
          ],
        ),
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
        String id = await createSIP();
        if (id == '200') {
          Navigator.push(
            context,
            PageTransition(
              child: const PaymentConfirmation(name: "SIP"),
              type: PageTransitionType.rightToLeft,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'You have issues in your mandate. Contact Customer Care'),
            ),
          );
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
          color: whiteColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.1),
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

  Future<String> createSIP() async {
    getData();

    if (mandate == null || mandate == '' || mandate == "0") {
      //Send to contact customer care
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'You have issues in your mandate. Contact Customer Care'),
        ),
      );
    } else {
//Check Mandate is Authorized :

      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var response = await http.get(
        Uri.parse(
            'https://api.fintechprimitives.com/api/pg/mandates?bank_account_id=$bankAccountId'),
        headers: headers,
      );

      var mandateJsonData = jsonDecode(response.body);

      if (mandateJsonData['mandates'] != null) {
        if (mandateJsonData['mandates'][0]['mandate_status'] != 'APPROVED') {
          //Place Transaction

          var body = {
            "orders": [
              {
                "isin": widget.isin,
                "amount": investmentAmount.text,
                "start_day": "20",
                "frequency": "MONTHLY",
                "installments": 1200,
                "mandate_id": mandate,
                "generate_first_installment_now": true,
              }
            ]
          };

          // Map<String, String> headers = {
          //   'authorization':
          //       'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMCIsInNjb3BlcyI6WyJ0ZW5hbnQiXSwidGVuYW50IjoiYW51cGFtZmluY28iLCJhcGlfa2V5X2lkIjoxLCJpc3MiOiJjeWJyaWxsYS1hdXRoIiwiaWF0IjoxNjU3Nzg1MjkyLCJleHAiOjE2NTc3ODcwOTJ9.i9IiVrXrSNnXf5Ew0EoHii7iMP4TnVIMgLwTn8TzENA',
          //   'Content-Type': 'application/json'
          // };

          var responsee = await http.post(
              Uri.parse(
                  'https://s.finprim.com/api/oms/investment_accounts/$investmentAccount/orders/sips'),
              headers: headers,
              body: json.encode(body));
          var jsonData = jsonDecode(responsee.body);
          return responsee.statusCode.toString();
          //END Place Transactions
        } else {
          Fluttertoast.showToast(
            msg: 'You need to athorize your mandate',
            backgroundColor: blackColor,
            textColor: whiteColor,
          );

          //API call to authozie

          await authorizedMandate(mandate);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Issue with your mandate - contact customer care',
          backgroundColor: blackColor,
          textColor: whiteColor,
        );
      }

      // setState(() {
      //   _isLoading = false;
      // });
    }
    return 'TRUE';
  }

  Future<String> authorizedMandate(String mandateID) async {
    var body = {
      "mandate_id": mandateID,
      "payment_postback_url": "https://www.poonjimitra.com/mandatereturn.html"
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse(
            'https://api.fintechprimitives.com/api/pg/payments/emandate/auth'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);
    setState(() {});

    if (jsonData["token_url"] != null) {
      _launchURL(jsonData["token_url"].toString());

      return jsonData["id"].toString();
    }
    return '0';
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> UpdateToken() async {
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
