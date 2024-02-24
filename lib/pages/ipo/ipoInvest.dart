import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';
import 'package:http/http.dart' as http;

class IpoInvest extends StatefulWidget {
  final String openingDate;
  final String closingDate;
  final String listingDate;
  final String marketLot;
  final String price;
  final String listing;
  final String ipoName;
  final String whyToInvest;

  const IpoInvest(
      {Key key,
      this.whyToInvest,
      this.ipoName,
      this.openingDate,
      this.closingDate,
      this.listingDate,
      this.marketLot,
      this.price,
      this.listing})
      : super(key: key);

  @override
  _IpoInvestState createState() => _IpoInvestState();
}

var fund;
var data;
var holdingList = [];
String selectedValue = null;

class _IpoInvestState extends State<IpoInvest> {
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

  final durationList = [
    {'duration': '1 Y Back'},
    {'duration': '3 Y Back'},
    {'duration': '5 Y Back'},
  ];

  final performanceList = [
    {
      'time': '1 Month',
      'fund': '+2.62%',
      'category': '-100%',
    },
    {
      'time': '3 Month',
      'fund': '+35.62%',
      'category': '+44.93%',
    },
    {
      'time': '6 Month',
      'fund': '-15.62%',
      'category': '-50.62%',
    },
    {
      'time': '1 Year',
      'fund': '+2.62%',
      'category': '-100%',
    },
    {
      'time': '3 Year',
      'fund': '+98.52%',
      'category': '-96.52%',
    },
    {
      'time': '5 Year',
      'fund': '+98.52%',
      'category': '-96.52%',
    },
  ];

  final List<Chart> chartData = [
    Chart('David', 25),
    Chart('Steve', 38),
    Chart('Jack', 34),
    Chart('Others', 52)
  ];

  final nameController = TextEditingController(text: '');

  final panController = TextEditingController(text: '');

  final emailController = TextEditingController(text: '');

  final phoneController = TextEditingController(text: '');

  final addressController = TextEditingController(text: '');

  final dpTypeController = TextEditingController(text: '');

  final dpIDController = TextEditingController(text: '');

  final lotsController = TextEditingController(text: '');

  final upiIDController = TextEditingController(text: '');

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
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: Text(
          widget.ipoName,
          style: white18BoldTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: whiteColor,
            ),
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
                        'Why to Invest',
                        style: white16BoldTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          widget.whyToInvest == null ? '' : widget.whyToInvest,
                          style: white12MediumTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              heightSpace,
              heightSpace,
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
            style: white16BoldTextStyle,
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
              cursorColor: whiteColor,
              style: white16BoldTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),

                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your Email ID',
            style: white16BoldTextStyle,
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
              cursorColor: whiteColor,
              style: white16BoldTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your 10 digit mobile no',
            style: white16BoldTextStyle,
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
              cursorColor: primaryColor,
              style: white16BoldTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your Address',
            style: white16BoldTextStyle,
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
              controller: addressController,
              cursorColor: whiteColor,
              style: white16BoldTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            'Choose DP Type',
            style: white14RegularTextStyle,
          ),
          heightSpace,
          heightSpace,
          DropdownButton<String>(
            dropdownColor: blackColor,
            items: <String>['NSDL', 'CDSL'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: white14RegularTextStyle,
                ),
              );
            }).toList(),
            hint: Text(
              'Select DP Type',
              style: white14RegularTextStyle,
            ),
            onChanged: (value) {
              setState(() {
                DpTypeValue = value;
              });
            },
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your DP ID',
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
                controller: dpIDController,
                cursorColor: whiteColor,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  // border: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: greyColor)),
                  // enabledBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: greyColor)),
                  // focusedBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: greyColor)),
                ),
              )),
          heightSpace,
          heightSpace,
          Text(
            'Number of Lots to Apply',
            style: white16BoldTextStyle,
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
              controller: lotsController,
              cursorColor: whiteColor,
              style: white16BoldTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            'Total Amount :',
            style: white16BoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Text(
            'Enter your UPI ID',
            style: white16BoldTextStyle,
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
                controller: upiIDController,
                cursorColor: whiteColor,
                style: white16BoldTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              )),
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
              child: Text(widget.ipoName.toString().substring(0, 1),
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
                        widget.ipoName, //data['fundName'],
                        style: white14RegularTextStyle,
                      ),
                      // ratingStars(widget.rating),
                    ],
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Lot Size  ',
                          style: orignalgrey14RegularTextStyle,
                        ),
                        TextSpan(
                          text: widget.marketLot +
                              ' Shares per lot', // data['nav'],
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
                  'Opening Date',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.openingDate == null ? 'NA' : widget.openingDate,
                  style: green14BoldTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Closing Date',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.closingDate == null ? 'NA' : widget.closingDate,
                  style: green14BoldTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Listing Date',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.listingDate == null ? 'NA' : widget.listingDate,
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
                List<String> name = await investIPO(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    addressController.text,
                    DpTypeValue,
                    dpIDController.text,
                    upiIDController.text);
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
                        backgroundColor: whiteColor,
                        textColor: blueColor,
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

  Future<List<String>> investIPO(String Fullname, String EmailID, String Mobile,
      String Address, String DPType, String DPID, String UPI) async {
    String uri = "http://api.poonjimitra.com/api/ipoOrder";
    var body = {
      "dpType": DpTypeValue,
      "dpNumber": dpIDController.text,
      "upi": upiIDController.text,
      "ipoName": widget.ipoName,
      "ipoId": "",
      "customerId": "",
      "invID": "0"
    };
    var response = await http
        .post(Uri.http('api.poonjimitra.com', 'api/ipoorders'), body: body);
    var jsonData = jsonDecode(response.body);
    List<String> name = [];
    name.add(jsonData.toString());

    return name;
  }
}
