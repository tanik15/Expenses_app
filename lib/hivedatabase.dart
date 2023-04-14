import 'package:expenses_app/expenses/expenses_item.dart';
import 'package:hive/hive.dart';

class hivedatabase {
  final _myBox = Hive.box("expense_databasee");

  void savedata(List<ExpenseItem> allexpense) {
    List<List<dynamic>> allexpansesformatted = [];

    for (var expense in allexpense) {
      List<dynamic> expenseformatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allexpansesformatted.add(expenseformatted);
    }
    _myBox.put("ALLEXPENSE", allexpansesformatted);
    // print(_myBox.getAt(0));
  }

  List<ExpenseItem> readdata() {
    List savedExpenses = _myBox.get("ALLEXPENSE") ?? [];
    print(savedExpenses);
    List<ExpenseItem> allexpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      print(name);
      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      allexpenses.add(expense);
    }
    return allexpenses;
  }
}
