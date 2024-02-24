import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';
import 'package:http/http.dart' as http;

class BondDetails extends StatefulWidget {
  final String couponRate;
  final String faceValue;
  final String timeTillMaturity;
  final String isinCode;
  final String type;
  final String bondName;
  final String rating;
  final String payoutFrequency;
  final String bondID;

  const BondDetails(
      {Key key,
      this.couponRate,
      this.faceValue,
      this.timeTillMaturity,
      this.type,
      this.isinCode,
      this.rating,
      this.bondName,
      this.bondID,
      this.payoutFrequency})
      : super(key: key);

  @override
  _IpoInvestState createState() => _IpoInvestState();
}

var fund;
var data;
var holdingList = [];
String selectedValue = null;

class _IpoInvestState extends State<BondDetails> {
  @override
  void initState() {
    super.initState();

    //var encodefund = jsonEncode(widget.jsonString);
    //fund = jsonDecode(encodefund);
    //data = jsonDecode(fund);

    // holdingList = jsonDecode(data['holdings']);
  }

  bool isSave = false;
  String calculater = 'SIP';
  String info = 'fund';
  int duration = 0;
  String DpTypeValue = '';

  final nameController = TextEditingController(text: '');

  final panController = TextEditingController(text: '');

  final emailController = TextEditingController(text: '');

  final phoneController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.push(
              context,
              PageTransition(
                child: const BottomBar(),
                type: PageTransitionType.rightToLeft,
              )),
          icon: const Icon(Icons.arrow_back, color: whiteColor),
        ),
        title: Text(
          widget.bondName,
          style: white18MediumTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: whiteColor),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isSave = !isSave;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: isSave
                      ? const Text('Added to save')
                      : const Text('Removed from save'),
                ),
              );
            },
            icon: Icon(
              isSave ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: whiteColor,
            ),
            iconSize: 20,
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(fixPadding * 2.0),
            children: [
              fundDetail(),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: white16BoldTextStyle,
                      ),
                      heightSpace,
                    ],
                  ),
                ],
              ),
              heightSpace,
              heightSpace,
              divider(),
              infoTextField(),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              investButton(),
              // performance(),
              const SizedBox(height: fixPadding * 6.0),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // investButton(),
                // LumpsumButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  infoTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter info & invest below',
            style: white14RegularTextStyle,
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your Full Name',
            style: white14RegularTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
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
                keyboardType: TextInputType.name,
                controller: nameController,
                cursorColor: primaryColor,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              )),
          heightSpace,
          heightSpace,
          Text(
            'Enter your Email ID',
            style: white14RegularTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
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
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                cursorColor: primaryColor,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              )),
          heightSpace,
          heightSpace,
          Text(
            'Enter your 10 digit mobile no',
            style: white14RegularTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
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
                keyboardType: TextInputType.phone,
                controller: phoneController,
                cursorColor: whiteColor,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              )),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  information(title, detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: grey12MediumTextStyle,
          ),
          Text(
            detail,
            style: black12SemiBoldTextStyle,
          ),
        ],
      ),
    );
  }

  fundDetail() {
    return Column(
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
              child: Text(widget.bondName.toString().substring(0, 1),
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
                        widget.bondName, //data['fundName'],
                        style: white14BoldTextStyle,
                      ),
                      // ratingStars(widget.rating),
                    ],
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Coupon Rate  ',
                          style: white14RegularTextStyle,
                        ),
                        TextSpan(
                          text: widget.couponRate, // data['nav'],
                          style: green12BoldTextStyle,
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
        divider(),
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Face Value',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.faceValue == null ? 'NA' : widget.faceValue,
                  style: green14BoldTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'ISIN ',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.isinCode == null ? 'NA' : widget.isinCode,
                  style: green14BoldTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Payout Frequency',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.payoutFrequency == null
                      ? 'NA'
                      : widget.payoutFrequency,
                  style: green14BoldTextStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  divider() {
    return Container(
      color: greyColor.withOpacity(0.4),
      height: 0.5,
      width: double.infinity,
    );
  }

  investButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => () async {
                currentIndex = 0;
                List<String> name = await investBonds();
                name.length == 2
                    ? Navigator.push(
                        context,
                        PageTransition(
                          child: const BottomBar(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      )
                    : Fluttertoast.showToast(
                        msg: 'Somethinng went wrong. Please try again later',
                        backgroundColor: blackColor,
                        textColor: whiteColor,
                      );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 10.0,
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
                  'Submit Order',
                  style: black16SemiBoldTextStyle,
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
      ],
    );
  }

  totalAmount(int lots, int marketLot, int ipoPorice) async {
    var totalShares = lots * marketLot;
    var totalAmount = totalShares * ipoPorice;

    return totalAmount.toString();
  }

  Future<List<String>> investBonds() async {
    String uri = "http://api.poonjimitra.com/api/bondOrders";
    var body = {
      "bondId": widget.bondID,
      "customerId": "0",
      "email": emailController.text,
    };
    var response = await http
        .post(Uri.http('api.poonjimitra.com', 'api/ipoorders'), body: body);
    var jsonData = jsonDecode(response.body);
    List<String> name = [];
    name.add(jsonData.toString());

    return name;
  }
}
