import 'package:expenses_app/expenses/expense_list.dart';
import 'package:expenses_app/expenses/expenses_item.dart';
import 'package:expenses_app/expenses/expenses_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expenses/expenses_data.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homepage();
}

class homepage extends State<home> {
  final ExpenseNameController = TextEditingController();
  final ExpenseAmountController = TextEditingController();

  void clear() {
    ExpenseNameController.clear();
    ExpenseAmountController.clear();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<expenseData>(context, listen: false).prepareData();
  }

  // var IconData = Icons.currency_rupee;
  // void cancel() {}
  @override
  Widget build(BuildContext context) {
    void deleteExpenses(ExpenseItem expenses) {
      Provider.of<expenseData>(context, listen: false).deleteExpense(expenses);
    }

    return Consumer<expenseData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              "My Expenses",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.grey[400],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Add Expenses here"),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextField(
                            controller: ExpenseNameController,
                            decoration: InputDecoration(
                              hintText: "Expense Name",
                            ),
                          ),
                          TextField(
                            controller: ExpenseAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Rupees",
                            ),
                          ),
                        ]),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              if(ExpenseNameController.text.isNotEmpty && ExpenseAmountController.text.isNotEmpty){
                                ExpenseItem newexpanse = ExpenseItem(
                                  name: ExpenseNameController.text,
                                  amount: ExpenseAmountController.text,
                                  dateTime: DateTime.now());
                              Provider.of<expenseData>(context, listen: false)
                                  .addNewExpense(newexpanse);
                              }
                              Navigator.pop(context);
                              clear();
                            },
                            child: Text("Save"),
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          )
                        ],
                      ));
            },
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                expensesummary(
                  startofweek: value.Startofweek(),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getallexpanselist().length,
                  itemBuilder: (context, index) => expenselisttile(
                      name: value.getallexpanselist()[index].name,
                      amount: value.getallexpanselist()[index].amount,
                      dateTime: value.getallexpanselist()[index].dateTime,
                      deletetapped: ((p0) =>
                          deleteExpenses(value.getallexpanselist()[index]))),
                )
              ],
            ),
          )),
    );
  }
}
