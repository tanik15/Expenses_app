


import 'package:expenses_app/expenses/timetostring.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bar/bargraph.dart';
import 'expenses_data.dart';

class expensesummary extends StatelessWidget {
  final DateTime startofweek;
  const expensesummary({super.key, required this.startofweek});

  double calculteMax(
    expenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculatetotal(
    expenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total = total += values[i];
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    Icon rupee = Icon(Icons.currency_rupee);
    String Sunday = datetimetostring(startofweek.add(const Duration(days: 0)));
    String Monday = datetimetostring(startofweek.add(const Duration(days: 1)));
    String Tuesday = datetimetostring(startofweek.add(const Duration(days: 2)));
    String Wednesday =
        datetimetostring(startofweek.add(const Duration(days: 3)));
    String Thursday =
        datetimetostring(startofweek.add(const Duration(days: 4)));
    String Friday = datetimetostring(startofweek.add(const Duration(days: 5)));
    String Saturday =
        datetimetostring(startofweek.add(const Duration(days: 6)));
    return Consumer<expenseData>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        "Week Total Expenses:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Icon(
                        Icons.currency_rupee,
                        size: 20,
                      ),
                      Text(
                        calculatetotal(value, Sunday, Monday, Tuesday,
                            Wednesday, Thursday, Friday, Saturday),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[500],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY: calculteMax(value, Sunday, Monday, Tuesday, Wednesday,
                        Thursday, Friday, Saturday),
                    sunAmount:
                        value.calculateDailyExpenseSummary()[Sunday] ?? 0,
                    monAmount:
                        value.calculateDailyExpenseSummary()[Monday] ?? 0,
                    tueAmount:
                        value.calculateDailyExpenseSummary()[Tuesday] ?? 0,
                    wedAmount:
                        value.calculateDailyExpenseSummary()[Wednesday] ?? 0,
                    thurAmount:
                        value.calculateDailyExpenseSummary()[Thursday] ?? 0,
                    friAmount:
                        value.calculateDailyExpenseSummary()[Friday] ?? 0,
                    satAmount:
                        value.calculateDailyExpenseSummary()[Saturday] ?? 0,
                  ),
                ),
              ],
            ));
  }
}
