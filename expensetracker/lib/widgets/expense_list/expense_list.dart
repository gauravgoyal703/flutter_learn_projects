import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.removeExpenses, {super.key, required this.expenses});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            onDismissed: (direction) {
              removeExpenses(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseItem(expense: expenses[index])));
  }
}
