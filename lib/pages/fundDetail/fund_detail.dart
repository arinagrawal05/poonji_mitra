import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';

class FundDetail extends StatefulWidget {
  final Color color;
  final String title;
  final int rating;
  final String investment;
  final String category;
  final String returns;
  final String isin;
  final String jsonString;
  const FundDetail(
      {Key key,
      this.title,
      this.rating,
      this.investment,
      this.category,
      this.returns,
      this.color,
      this.isin,
      this.jsonString})
      : super(key: key);

  @override
  _FundDetailState createState() => _FundDetailState();
}

var fund;
var data;
var holdingList;

class _FundDetailState extends State<FundDetail> {
  @override
  void initState() {
    super.initState();
    var encodefund = jsonEncode(widget.jsonString);
    fund = jsonDecode(encodefund);
    data = jsonDecode(fund);

    holdingList = jsonDecode(data['holdings']);
  }

  bool isSave = false;
  String calculater = 'SIP';
  String info = 'fund';
  int duration = 0;

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

  @override
  Widget build(BuildContext context) {
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
          data['fundName'],
          style: white18BoldTextStyle,
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
                isSave
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_outline_rounded,
                color: whiteColor),
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
                        'About the fund',
                        style: white16BoldTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data['about'],
                          style: grey12MediumTextStyle,
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
              //chart(),
              heightSpace,
              heightSpace,
              // heightSpace,
              // heightSpace,
              // calculator(),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              returns(),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              holding(),
              heightSpace,
              heightSpace,
              heightSpace,
              // riskometer(),
              fundInfo(),
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
                        'Investment Objective',
                        style: white16BoldTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data['investmentObjective'],
                          style: grey12MediumTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                investButton(),
                LumpsumButton(),
              ],
            ),
          ),
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
            style: white12MediumTextStyle,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['fundName'],
                        style: white14RegularTextStyle,
                      ),
                      ratingStars(widget.rating),
                    ],
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'NAV ',
                          style: white14RegularTextStyle,
                        ),
                        TextSpan(
                          text: data['nav'],
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
                  'Min Investment',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  'Rs ' + data['minimumSIP'],
                  style: green14BoldTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'AUM (Crs)',
                  style: grey12RegularTextStyle,
                ),
                const SizedBox(height: 18),
                Text(
                  'Rs. ' + data['aum'],
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
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '1Y',
                          style: grey12RegularTextStyle,
                        ),
                        Text(
                          data['oneYearCAGR'],
                          style: red14BoldTextStyle,
                        ),
                      ],
                    ),
                    widthSpace,
                    widthSpace,
                    Column(
                      children: [
                        Text(
                          '3Y',
                          style: grey12RegularTextStyle,
                        ),
                        Text(
                          data['threeYearCAGR'],
                          style: red14BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  chart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: limeColor,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final flSpot = barSpot;
                  return LineTooltipItem(
                    flSpot.x.round().toString(),
                    const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: ' Nov 2019 NAV: ',
                      ),
                      TextSpan(
                        text: flSpot.y.toString(),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
            border:
                const Border(bottom: BorderSide(color: greyColor, width: 2)),
          ),
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(1, 9),
                FlSpot(2, 8.3),
                FlSpot(3, 8),
                FlSpot(4, 10),
                FlSpot(5, 20),
                FlSpot(6, 36.2),
                FlSpot(7, 33.9),
                FlSpot(8, 19.7),
                FlSpot(9, 22.5),
                FlSpot(10, 19.7),
                FlSpot(11, 32.1),
                FlSpot(12, 34),
                FlSpot(13, 25.3),
                FlSpot(14, 30.2),
                FlSpot(15, 28.5),
                FlSpot(16, 35.02),
                FlSpot(17, 37.1),
                FlSpot(18, 36.1),
                FlSpot(19, 39.5),
                FlSpot(20, 45.8),
                FlSpot(21, 50.3),
                FlSpot(22, 45.9),
                FlSpot(23, 30.8),
                FlSpot(24, 35.8),
                FlSpot(25, 40.8),
                FlSpot(26, 38.9),
                FlSpot(27, 32.8),
                FlSpot(28, 39.8),
                FlSpot(29, 40.8),
                FlSpot(30, 40),
              ],
              isCurved: true,
              colors: [primaryColor],
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradientTo: const Offset(0, 1.9),
                colors: [
                  primaryColor,
                  whiteColor,
                  limeColor,
                ],
              ),
            ),
          ],
          titlesData: FlTitlesData(
            show: true,
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTextStyles: (context, value) => grey14MediumTextStyle,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 1:
                    return '1D';
                  case 5:
                    return '1W';
                  case 10:
                    return '1M';
                  case 15:
                    return '3M';
                  case 20:
                    return '1Y';
                  case 25:
                    return '5Y';
                  case 30:
                    return 'ALL';
                }
                return '';
              },
            ),
            leftTitles: SideTitles(
              showTitles: false,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return '1';
                  case 2:
                    return '5';
                  case 4:
                    return '10';
                  case 6:
                    return '15';
                  case 8:
                    return '20';
                  case 10:
                    return '25';
                  case 12:
                    return '30';
                }
                return '';
              },
            ),
          ),
        ),
      ),
    );
  }

  calculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SIP/One Time Calculator',
          style: black16SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  calculater = 'SIP';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: calculater == 'SIP'
                      ? const Border(
                          bottom: BorderSide(color: primaryColor),
                        )
                      : const Border(),
                ),
                child: Text(
                  'SIP',
                  style: calculater == 'SIP'
                      ? primaryColor14MediumTextStyle
                      : black14MediumTextStyle,
                ),
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            InkWell(
              onTap: () {
                setState(() {
                  calculater = 'One Time';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: calculater == 'One Time'
                      ? const Border(
                          bottom: BorderSide(color: primaryColor),
                        )
                      : const Border(),
                ),
                child: Text(
                  'One Time',
                  style: calculater == 'One Time'
                      ? primaryColor14MediumTextStyle
                      : black14MediumTextStyle,
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum SIP Amount',
              style: grey12MediumTextStyle,
            ),
            Text(
              'Rs.1000',
              style: black12SemiBoldTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amount per month',
              style: grey12MediumTextStyle,
            ),
            Text(
              'Rs.1000',
              style: black12SemiBoldTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        divider(),
        heightSpace,
        heightSpace,
        heightSpace,
        Text(
          'Duration',
          style: black14MediumTextStyle,
        ),
        heightSpace,
        heightSpace,
        SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: durationList.length,
            itemBuilder: (context, index) {
              final item = durationList[index];
              return Padding(
                padding: const EdgeInsets.only(right: fixPadding),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      duration = index;
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding,
                      vertical: 7,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          duration == index ? primaryColor : Colors.transparent,
                      border: Border.all(
                          color: duration == index
                              ? primaryColor
                              : greyColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      item['duration'],
                      style: duration == index
                          ? white12MediumTextStyle
                          : grey12MediumTextStyle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  returns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Returns',
          style: white16BoldTextStyle,
        ),
        heightSpace,
        Table(
          columnWidths: const {
            0: FractionColumnWidth(.4),
            1: FractionColumnWidth(.15),
            2: FractionColumnWidth(.15),
            3: FractionColumnWidth(.15),
            4: FractionColumnWidth(.15)
          },
          children: [
            TableRow(
              children: [
                Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    '1Y',
                    textAlign: TextAlign.center,
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    '3Y',
                    textAlign: TextAlign.center,
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    '5Y',
                    textAlign: TextAlign.center,
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    'Funds Returns',
                    style: grey12MediumTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    data['oneYearCAGR'],
                    textAlign: TextAlign.center,
                    style: white12MediumTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    data['threeYearCAGR'],
                    textAlign: TextAlign.center,
                    style: white12MediumTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    data['fiveYearCAGR'],
                    textAlign: TextAlign.center,
                    style: white12MediumTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style: white12MediumTextStyle,
                  ),
                ),
              ],
            ),
            // TableRow(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         'Category Average',
            //         style: grey12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '19.4%',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '6.1%',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '3.2%',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '-',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //   ],
            // ),
            // TableRow(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         'Rank Within',
            //         style: grey12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '6',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '1',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '1',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
            //       child: Text(
            //         '-',
            //         textAlign: TextAlign.center,
            //         style: black12MediumTextStyle,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }

  holding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Holding',
          style: white16BoldTextStyle,
        ),
        heightSpace,
        Table(
          columnWidths: const {
            0: FractionColumnWidth(.8),
            1: FractionColumnWidth(.17),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    'Name',
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                  child: Text(
                    'Assets',
                    style: grey14SemiBoldTextStyle,
                  ),
                ),
              ],
            ),
            for (var item in holdingList)
              TableRow(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: fixPadding / 2),
                    child: Text(
                      item['id'],
                      style: grey12MediumTextStyle,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: fixPadding / 2),
                    child: Text(
                      item['value'],
                      style: white12MediumTextStyle,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  riskometer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Riskometer',
          style: black16SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        SizedBox(
          height: 180,
          child: DChartGauge(
            data: const [
              {'domain': 'Low', 'measure': 30},
              {'domain': '', 'measure': 20},
              {'domain': 'Low Moderate', 'measure': 30},
              {'domain': '', 'measure': 20},
              {'domain': 'Moderate', 'measure': 30},
              {'domain': '', 'measure': 20},
              {'domain': 'High Moderate', 'measure': 30},
              {'domain': '', 'measure': 20},
              {'domain': 'High', 'measure': 30},
            ],
            fillColor: (pieData, index) {
              switch (pieData['domain']) {
                case 'Low':
                  return const Color(0xff96FAA0);
                case 'Low1':
                  return whiteColor;
                case 'Low Moderate':
                  return const Color(0xff6EC239);
                case 'LowModerate1':
                  return whiteColor;
                case 'Moderate':
                  return const Color(0xffF9CA24);
                case 'Moderate1':
                  return whiteColor;
                case 'High Moderate':
                  return const Color(0xffFB9435);
                case 'HighModerate1':
                  return whiteColor;
                case 'High':
                  return const Color(0xffFD0505);
                default:
                  return whiteColor;
              }
            },
            showLabelLine: false,
            pieLabel: (pieData, index) {
              return "${pieData['domain']}";
            },
            labelPosition: PieLabelPosition.outside,
            labelPadding: 0,
            labelColor: greyColor,
            donutWidth: 50,
          ),
        ),
      ],
    );
  }

  fundInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fund Information',
          style: white16BoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  info = 'fund';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: info == 'fund'
                      ? const Border(
                          bottom: BorderSide(color: whiteColor),
                        )
                      : const Border(),
                ),
                child: Text(
                  'Fund Info',
                  style: info == 'fund'
                      ? white14RegularTextStyle
                      : white14RegularTextStyle,
                ),
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            InkWell(
              onTap: () {
                setState(() {
                  info = 'amc';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: info == 'amc'
                      ? const Border(
                          bottom: BorderSide(color: whiteColor),
                        )
                      : const Border(),
                ),
                child: Text(
                  'AMC Info',
                  style: info == 'amc'
                      ? white14RegularTextStyle
                      : white14RegularTextStyle,
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        Table(
          columnWidths: const {
            0: FractionColumnWidth(.5),
            1: FractionColumnWidth(.5),
          },
          children: [
            TableRow(
              children: [
                information('Fund Type', 'Open End'),
                information('Plan', ' Regular Growth'),
              ],
            ),
            TableRow(
              children: [
                information('Launched Date', data['launchedDate']),
                information('Expense Ratio', data['expenseRatio']),
              ],
            ),
            TableRow(
              children: [
                information('Cash Holding', 'NA'),
                information('As on Date', 'NA'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  performance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Past Performance',
          style: black16SemiBoldTextStyle,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          color: greyColor.withOpacity(0.1),
          child: Table(
            columnWidths: const {
              0: FractionColumnWidth(.13),
              1: FractionColumnWidth(.13),
              2: FractionColumnWidth(.22),
              3: FractionColumnWidth(.13),
            },
            children: [
              TableRow(
                children: [
                  Container(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: fixPadding / 2),
                    child: Text(
                      'Fund',
                      textAlign: TextAlign.center,
                      style: grey14BoldTextStyle,
                    ),
                  ),
                  Container(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: fixPadding / 2),
                    child: Text(
                      'Category',
                      textAlign: TextAlign.center,
                      style: grey14BoldTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ColumnBuilder(
          itemCount: performanceList.length,
          itemBuilder: (context, index) {
            final item = performanceList[index];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                0,
                fixPadding,
                0,
                fixPadding,
              ),
              decoration: BoxDecoration(
                border: index == performanceList.length - 1
                    ? const Border()
                    : Border(
                        bottom: BorderSide(color: greyColor.withOpacity(0.4)),
                      ),
              ),
              child: Table(
                columnWidths: const {
                  0: FractionColumnWidth(.13),
                  1: FractionColumnWidth(.13),
                  2: FractionColumnWidth(.22),
                  3: FractionColumnWidth(.13),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          fixPadding,
                          fixPadding / 3,
                          0,
                          0,
                        ),
                        child: Text(
                          item['time'],
                          style: grey14MediumTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: fixPadding / 3),
                        child: Text(
                          item['fund'],
                          textAlign: TextAlign.center,
                          style:
                              (item['fund'].toString().substring(0, 1) == '+')
                                  ? green14SemiBoldTextStyle
                                  : red14SemiBoldTextStyle,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: greyColor.withOpacity(0.4),
                              height: 1,
                            ),
                          ),
                          widthSpace,
                          Container(
                            padding: const EdgeInsets.all(fixPadding / 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: greyColor.withOpacity(0.4)),
                            ),
                            child: Text(
                              'VS',
                              style: grey10SemiBoldTextStyle,
                            ),
                          ),
                          widthSpace,
                          Expanded(
                            child: Container(
                              color: greyColor.withOpacity(0.4),
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: fixPadding / 3),
                        child: Text(
                          item['category'],
                          textAlign: TextAlign.center,
                          style: (item['category'].toString().substring(0, 1) ==
                                  '+')
                              ? green14SemiBoldTextStyle
                              : red14SemiBoldTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
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
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  child: Invest(
                    color: widget.color,
                    title: widget.title,
                    plan: 'Growth',
                    type: calculater,
                    isin: widget.isin,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 5.0,
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
                  'SIP',
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

  LumpsumButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  child: Lumpsum(
                    color: widget.color,
                    title: widget.title,
                    plan: 'Growth',
                    type: calculater,
                    isin: widget.isin,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 3.0,
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
                  'Lumpsum',
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
}

class Chart {
  Chart(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
