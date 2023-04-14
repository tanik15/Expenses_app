import 'individualgraph.dart';

class Bardata {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  Bardata({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<individualbargraph> bardata = [];

  void initialiseBarData() {
    bardata = [
      individualbargraph(x: 0, y: sunAmount),
      individualbargraph(x: 1, y: monAmount),
      individualbargraph(x: 2, y: tueAmount),
      individualbargraph(x: 3, y: wedAmount),
      individualbargraph(x: 4, y: thurAmount),
      individualbargraph(x: 5, y: friAmount),
      individualbargraph(x: 6, y: satAmount),
    ];
  }
}
