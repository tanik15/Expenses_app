

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class expenselisttile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deletetapped;

  expenselisttile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deletetapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deletetapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString()),
        trailing: Text('\$'+amount ),
      ),
    );
  }
}