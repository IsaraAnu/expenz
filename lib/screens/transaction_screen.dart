import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/icnome_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  final void Function(Expense) onDissmissedExpense;
  final void Function(Income) onDissmissedIncome;
  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.onDissmissedExpense,
    required this.onDissmissedIncome,
    required this.incomesList,
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
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.expensesList.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 10,
                                  top: 80,
                                ),
                                child: Text(
                                  "No expenses added yet ,\nadd some expenses to see here",
                                  style: TextStyle(
                                    color: kGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : ListView.builder(
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
              SizedBox(height: 20),
              Text(
                "Incomes",
                style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
              // show the all expenses  as a list
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.29,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.incomesList.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 10,
                                  top: 80,
                                ),
                                child: Text(
                                  "No incomes added yet ,\nadd some incomes to see here",
                                  style: TextStyle(
                                    color: kGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.incomesList.length,
                              itemBuilder: (context, index) {
                                final income = widget.incomesList[index];

                                return Dismissible(
                                  key: ValueKey(income),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    setState(() {
                                      widget.onDissmissedIncome(income);
                                    });
                                  },

                                  child: IncomeCard(
                                    title: income.title,
                                    date: income.date,
                                    amount: income.amount,
                                    category: income.category,
                                    description: income.description,
                                    time: income.time,
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
