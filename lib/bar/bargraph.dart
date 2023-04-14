

import 'package:expenses_app/bar/bardata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    Bardata myBarData = Bardata(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount);

    myBarData.initialiseBarData();
    return BarChart(BarChartData(
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getbottomtitle,
        )),
      ),
      maxY: maxY,
      minY: 0,
      barGroups: myBarData.bardata
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    toY: data.y,
                    color: Colors.black,
                    width: 25,
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, color: Colors.white, toY: maxY),
                    borderRadius: BorderRadius.circular(4))
              ]))
          .toList(),
    ));
  }
}

Widget getbottomtitle(double value, TitleMeta meta) {
  const stylee = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("S", style: stylee);
      break;
    case 1:
      text = const Text("M", style: stylee);
      break;
    case 2:
      text = const Text("Tu", style: stylee);
      break;
    case 3:
      text = const Text("W", style: stylee);
      break;
    case 4:
      text = const Text("Th", style: stylee);
      break;
    case 5:
      text = const Text("F", style: stylee);
      break;
    case 6:
      text = const Text("Sa", style: stylee);
      break;
    default:
      text = const Text("", style: stylee);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
