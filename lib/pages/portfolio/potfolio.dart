import 'package:fl_chart/fl_chart.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class Portfolio extends StatelessWidget {
  Portfolio({Key key}) : super(key: key);

  double height;

  final summaryList = [
    {
      'title': 'Mutual Funds',
      'time': 'as of Oct 17 2020, 9:45 am',
      'investedAmount': 'Rs. 13,250.59',
      'returns': 'Rs. 45,580.96',
      'currentValue': 'Rs. 15,589.36',
      'status': 'up',
      'barData': const [
        FlSpot(1, 30000),
        FlSpot(2, 35000.50),
        FlSpot(3, 40000),
        FlSpot(4, 90000),
        FlSpot(5, 110000),
        FlSpot(6, 95000.75),
        FlSpot(7, 85000.50),
        FlSpot(8, 100000.49),
        FlSpot(9, 99000),
        FlSpot(10, 90000.07),
        FlSpot(11, 85000.61),
        FlSpot(12, 70000),
        FlSpot(13, 60000.2),
        FlSpot(14, 55000.9),
        FlSpot(15, 69999.10),
        FlSpot(16, 120000.22),
        FlSpot(17, 100000.4),
        FlSpot(18, 115000.8),
        FlSpot(19, 100000.75),
        FlSpot(20, 110500.75),
        FlSpot(21, 120000.30),
        FlSpot(22, 135000.99),
        FlSpot(23, 115000.77),
        FlSpot(24, 107000),
        FlSpot(25, 115000.23),
        FlSpot(26, 125000.22),
        FlSpot(27, 130000),
        FlSpot(28, 140000.12),
        FlSpot(29, 150000.51),
        FlSpot(30, 155000),
      ],
    },
    {
      'title': 'Stocks',
      'time': 'as of Oct 17 2020, 9:45 am',
      'investedAmount': 'Rs. 13,250.59',
      'returns': 'Rs. 45,580.96',
      'currentValue': 'Rs. 10,589.36',
      'status': 'down',
      'barData': const [
        FlSpot(1, 155000),
        FlSpot(2, 150000.51),
        FlSpot(3, 140000.12),
        FlSpot(4, 130000),
        FlSpot(5, 125000.22),
        FlSpot(6, 115000.23),
        FlSpot(7, 107000),
        FlSpot(8, 115000.77),
        FlSpot(9, 135000.99),
        FlSpot(10, 120000.30),
        FlSpot(11, 110500.75),
        FlSpot(12, 100000.75),
        FlSpot(13, 115000.8),
        FlSpot(14, 100000.4),
        FlSpot(15, 120000.22),
        FlSpot(16, 69999.10),
        FlSpot(17, 55000.9),
        FlSpot(18, 60000.2),
        FlSpot(19, 70000),
        FlSpot(20, 85000.61),
        FlSpot(21, 90000.07),
        FlSpot(22, 99000),
        FlSpot(23, 100000.49),
        FlSpot(24, 85000.50),
        FlSpot(25, 95000.75),
        FlSpot(26, 110000),
        FlSpot(27, 90000),
        FlSpot(28, 40000),
        FlSpot(29, 35000.50),
        FlSpot(30, 30000),
      ],
    },
    {
      'title': 'Bonds',
      'time': 'as of Oct 17 2020, 9:45 am',
      'investedAmount': 'Rs. 13,250.59',
      'returns': 'Rs. 45,580.96',
      'currentValue': 'Rs. 10,589.36',
      'status': 'down',
      'barData': const [
        FlSpot(1, 155000),
        FlSpot(2, 150000.51),
        FlSpot(3, 140000.12),
        FlSpot(4, 130000),
        FlSpot(5, 125000.22),
        FlSpot(6, 115000.23),
        FlSpot(7, 107000),
        FlSpot(8, 115000.77),
        FlSpot(9, 135000.99),
        FlSpot(10, 120000.30),
        FlSpot(11, 110500.75),
        FlSpot(12, 100000.75),
        FlSpot(13, 115000.8),
        FlSpot(14, 100000.4),
        FlSpot(15, 120000.22),
        FlSpot(16, 69999.10),
        FlSpot(17, 55000.9),
        FlSpot(18, 60000.2),
        FlSpot(19, 70000),
        FlSpot(20, 85000.61),
        FlSpot(21, 90000.07),
        FlSpot(22, 99000),
        FlSpot(23, 100000.49),
        FlSpot(24, 85000.50),
        FlSpot(25, 95000.75),
        FlSpot(26, 110000),
        FlSpot(27, 90000),
        FlSpot(28, 40000),
        FlSpot(29, 35000.50),
        FlSpot(30, 30000),
      ],
    },
  ];

  final List<ChartData> chartData = [
    ChartData('Mutual Funds\n60.30%', 60.30, const Color(0xff757DE8)),
    ChartData('Stocks\n30.15%', 30.15, const Color(0xffD05CE3)),
    ChartData('Bonds\n20.27%', 20.27, const Color(0xffFF6090)),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Portfolio',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          chart(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          summary(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          analytics(),
        ],
      ),
    );
  }

  chart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Investment Value',
          style: grey14MediumTextStyle,
        ),
        Text(
          'Rs. 31,70,152.75',
          style: green14SemiBoldTextStyle,
        ),
        Text(
          'as of Dec 17 2020, 09:55 am',
          style: grey12RegularTextStyle,
        ),
        Container(
          height: height * 0.18,
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                    bottom: BorderSide(color: greyColor, width: 2)),
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: limeColor,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      return LineTooltipItem(
                        flSpot.y.toString(),
                        const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              minY: 0,
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(1, 30000),
                    FlSpot(2, 35000.50),
                    FlSpot(3, 40000),
                    FlSpot(4, 90000),
                    FlSpot(5, 110000),
                    FlSpot(6, 95000.75),
                    FlSpot(7, 70000.50),
                    FlSpot(8, 65000.49),
                    FlSpot(9, 100000),
                    FlSpot(10, 120000.07),
                    FlSpot(11, 130000.61),
                    FlSpot(12, 120000),
                    FlSpot(13, 130000.2),
                    FlSpot(14, 85000.9),
                    FlSpot(15, 69999.10),
                    FlSpot(16, 60000.22),
                    FlSpot(17, 75000.4),
                    FlSpot(18, 150000.8),
                    FlSpot(19, 170500.75),
                    FlSpot(20, 170500.75),
                    FlSpot(21, 160000.30),
                    FlSpot(22, 135000.99),
                    FlSpot(23, 115000.77),
                    FlSpot(24, 107000),
                    FlSpot(25, 115000.23),
                    FlSpot(26, 115000.22),
                    FlSpot(27, 107000),
                    FlSpot(28, 140000.12),
                    FlSpot(29, 150000.51),
                    FlSpot(30, 155000),
                  ],
                  isCurved: true,
                  // colors: [primaryColor],
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
                  reservedSize: 22,
                  interval: 1,
                  getTextStyles: (context, value) => grey14MediumTextStyle,
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 1:
                        return '8\nMay';
                      case 5:
                        return '9\nMay';
                      case 10:
                        return '10\nMay';
                      case 15:
                        return '11\nMay';
                      case 20:
                        return '12\n May';
                      case 25:
                        return '13\nMay';
                      case 30:
                        return '14\nMay';
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: false,
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return '10k';
                      case 2:
                        return '20k';
                      case 4:
                        return '30k';
                      case 6:
                        return '50k';
                      case 8:
                        return '60k';
                      case 10:
                        return '70k';
                      case 12:
                        return '80k';
                    }
                    return '';
                  },
                ),
              ),
            ),
          ),
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Investment',
                  style: grey14RegularTextStyle,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rs.30,00,000 ',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextSpan(
                        text: '(+21.65%)',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widthSpace,
            const SizedBox(width: 3.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Returns',
                  style: grey14RegularTextStyle,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rs.1,70,500.75 ',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextSpan(
                        text: '(+5.69%)',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  summary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Portfolio Summary',
          style: black18SemiBoldTextStyle,
        ),
        ColumnBuilder(
          itemCount: summaryList.length,
          itemBuilder: (context, index) {
            final item = summaryList[index];
            return Padding(
              padding: const EdgeInsets.only(top: fixPadding),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: PortfolioStocks(),
                    type: PageTransitionType.rightToLeft,
                  ),
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
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: black16MediumTextStyle,
                              ),
                              Text(
                                item['time'],
                                style: grey12RegularTextStyle,
                              ),
                              heightSpace,
                              heightSpace,
                              Text(
                                'Invested Amount',
                                style: grey14MediumTextStyle,
                              ),
                              Text(
                                item['investedAmount'],
                                style: green14SemiBoldTextStyle,
                              ),
                            ],
                          ),
                          widthSpace,
                          SizedBox(
                            height: height * 0.1,
                            width: MediaQuery.of(context).size.width / 2 - 27,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(show: false),
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: limeColor,
                                    getTooltipItems:
                                        (List<LineBarSpot> touchedBarSpots) {
                                      return touchedBarSpots.map((barSpot) {
                                        final flSpot = barSpot;
                                        return LineTooltipItem(
                                          flSpot.y.toString(),
                                          const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: item['barData'],
                                    isCurved: true,
                                    colors: [primaryColor],
                                    shadow: const Shadow(
                                      offset: Offset(0, 4),
                                      color: limeColor,
                                      blurRadius: 2,
                                    ),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      heightSpace,
                      heightSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overall Returns',
                                    style: grey14RegularTextStyle,
                                  ),
                                  Text(
                                    item['returns'],
                                    style: green14MediumTextStyle,
                                  ),
                                ],
                              ),
                              widthSpace,
                              widthSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Value',
                                    style: grey14RegularTextStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item['currentValue'],
                                        style: item['status'] == 'up'
                                            ? green14MediumTextStyle
                                            : red14MediumTextStyle,
                                      ),
                                      Icon(
                                        item['status'] == 'up'
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: item['status'] == 'up'
                                            ? greenColor
                                            : Colors.red,
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: primaryColor,
                            size: 20,
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
    );
  }

  analytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics',
          style: black18SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        Stack(
          children: [
            SizedBox(
              height: 200,
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: const TextStyle(
                    color: greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    startAngle: 90,
                    endAngle: 450,
                    dataSource: chartData,
                    innerRadius: '87%',
                    radius: '120%',
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    cornerStyle: CornerStyle.bothCurve,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 65,
              left: 118,
              child: Center(
                child: Text(
                  'Rs.31,70,152.75',
                  style: black16BoldTextStyle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
