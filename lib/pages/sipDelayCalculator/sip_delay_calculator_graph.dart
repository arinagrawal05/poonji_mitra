import 'package:investment_zone/pages/screens.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SIPDelayCalculatorGraph extends StatelessWidget {
  const SIPDelayCalculatorGraph({Key key}) : super(key: key);

  List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: '0', y: 45000, secondSeriesYValue: 45000),
      ChartSampleData(x: '0.5', y: 75000, secondSeriesYValue: 75000),
      ChartSampleData(x: '1', y: 419000, secondSeriesYValue: 379000),
      ChartSampleData(x: '1.5', y: 285000, secondSeriesYValue: 248000),
      ChartSampleData(x: '2', y: 309000, secondSeriesYValue: 289000),
      ChartSampleData(x: '2.5', y: 129650, secondSeriesYValue: 114000),
      ChartSampleData(x: '3', y: 90000, secondSeriesYValue: 59000),
      ChartSampleData(x: '3.5', y: 80000, secondSeriesYValue: 58500),
      ChartSampleData(x: '4', y: 350000, secondSeriesYValue: 300000),
      ChartSampleData(x: '4.5', y: 411000, secondSeriesYValue: 385000),
      ChartSampleData(x: '5', y: 155500, secondSeriesYValue: 130000),
      ChartSampleData(x: '5.5', y: 210000, secondSeriesYValue: 190000),
      ChartSampleData(x: '6', y: 119000, secondSeriesYValue: 100000),
      ChartSampleData(x: '6.5', y: 420000, secondSeriesYValue: 380000),
      ChartSampleData(x: '7', y: 280000, secondSeriesYValue: 250000),
      ChartSampleData(x: '7.5', y: 600000, secondSeriesYValue: 550000),
      ChartSampleData(x: '8', y: 700000, secondSeriesYValue: 650000),
    ];
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: false),
        color: greenColor,
        name: 'Amount Accumulated:',
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        name: 'Amount Invested:',
        color: Colors.red,
        markerSettings: const MarkerSettings(isVisible: false),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'SIP Delay Calculator',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                interval: 2,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                labelPlacement: LabelPlacement.onTicks,
                labelStyle: grey12MediumTextStyle,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}',
                minimum: 0,
                maximum: 700000,
                interval: 100000,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                edgeLabelPlacement: EdgeLabelPlacement.none,
                axisLine: const AxisLine(width: 0),
              ),
              series: _getDefaultSplineSeries(),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: limeColor,
                textStyle: primaryColor12BoldTextStyle,
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          calculateButton(context),
        ],
      ),
    );
  }

  calculateButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 4.5,
              vertical: fixPadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              'RE-CALCULATE',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num y;
  final dynamic xValue;
  final num yValue;
  final num secondSeriesYValue;
  final num thirdSeriesYValue;
  final Color pointColor;
  final num size;
  final String text;
  final num open;
  final num close;
  final num low;
  final num high;
  final num volume;
}

// class SalesData {
//   SalesData(this.x, this.y, [this.date, this.color]);

//   final dynamic x;
//   final dynamic y;
//   final Color color;
//   final DateTime date;
// }
