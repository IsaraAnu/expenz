import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/icnome_model.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:expenz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedMethod = 0;

  // method to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedMethod == 0
        ? widget.expenseCategoryTotal
        : widget.incomeCategoryTotal;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            color: kBlack,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kBlack.withOpacity(0.1),
                        blurRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: kLightGrey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 0
                                ? kMainColor
                                : kLightGrey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 56,
                            ),
                            child: Text(
                              "Expence",
                              style: TextStyle(
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 1
                                ? kMainColor
                                : kLightGrey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 56,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // pie chart
              Chart(
                expenseCategoryTotal: widget.expenseCategoryTotal,
                incomeCategoryTotal: widget.incomeCategoryTotal,
                isExpense: _selectedMethod == 0,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,

                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final allAmount = data.values.toList()[index];

                    return CategoryCard(
                      title: category.name,
                      amount: allAmount,
                      total: data.values.reduce(
                        (value, element) => value + element,
                      ),
                      progressColor: getCategoryColor(category),
                      isExepense: _selectedMethod == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
