import 'dart:ffi';

import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final void Function(Expense) onDissmissedExpense;
  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.onDissmissedExpense,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See your financial report",
                style: TextStyle(
                  color: kMainColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Expenses",
                style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
              // show the all expenses  as a list
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.expensesList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expensesList[index];

                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDissmissedExpense(expense);
                              });
                            },

                            child: ExpenseCard(
                              title: expense.title,
                              date: expense.date,
                              amount: expense.amount,
                              category: expense.category,
                              description: expense.description,
                              time: expense.time,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
