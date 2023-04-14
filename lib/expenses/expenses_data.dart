import 'package:expenses_app/expenses/timetostring.dart';
import 'package:expenses_app/hivedatabase.dart';
import 'package:flutter/cupertino.dart';
import 'expenses_item.dart';

class expenseData extends ChangeNotifier {

  // list of all data
  List<ExpenseItem> overallexpancelist = [];
  //get expenses list
  List<ExpenseItem> getallexpanselist() {
    return overallexpancelist;
  }

  final db = hivedatabase();
  void prepareData() {
    if (db.readdata().isNotEmpty) {
      overallexpancelist = db.readdata();
    }
  }

  //add new expenses
  void addNewExpense(ExpenseItem newexpanse) {
    overallexpancelist.add(newexpanse);

    notifyListeners();
    db.savedata(overallexpancelist);
  }

  //delete expenses
  void deleteExpense(ExpenseItem expanse) {
    overallexpancelist.remove(expanse);
    notifyListeners();
    db.savedata(overallexpancelist);
  }

  //get week day(mon,tue) from date time object
  String getDayname(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return " ";
    }
  }

  DateTime Startofweek() {
    DateTime? Startofweek;

    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayname(today.subtract(Duration(days: i))) == 'Sun') {
        Startofweek = today.subtract(Duration(days: i));
      }
    }
    return Startofweek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyexpensesummary = {};
    for (var expense in overallexpancelist) {
      String date = datetimetostring(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyexpensesummary.containsKey(date)) {
        double currentamount = dailyexpensesummary[date]!;
        currentamount += amount;
        dailyexpensesummary[date] = currentamount;
      } else {
        dailyexpensesummary.addAll({date: amount});
      }
    }
    return dailyexpensesummary;
  }
}
