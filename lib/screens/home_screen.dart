import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/icnome_model.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/icome_expence_card.dart';
import 'package:expenz/widgets/line_chart_sample.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomesList;

  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomesList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the usernam
  String username = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    //get the username from the shared pref
    UserServices.getUserData().then((value) {
      if (value["userName"] != null) {
        setState(() {
          username = value["userName"]!;
        });
      }
      setState(() {
        for (var i = 0; i < widget.expenseList.length; i++) {
          expenseTotal += widget.expenseList[i].amount;
        }
      });
      setState(() {
        for (var i = 0; i < widget.incomesList.length; i++) {
          incomeTotal += widget.incomesList[i].amount;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // sub column with bg color
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kLightGrey,
                              border: Border.all(color: kMainColor, width: 5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 30),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IcomeExpenceCard(
                            title: "Income",
                            amount: incomeTotal,
                            imageUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IcomeExpenceCard(
                            title: "Expence",
                            amount: expenseTotal,
                            imageUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // line chart
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: kBlack,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LineChartSample(),
                    // recent transactions
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Recent Transaction",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: kBlack,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              widget.expenseList.isEmpty
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 10,
                                          top: 50,
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
                                      itemCount: widget.expenseList.length,
                                      itemBuilder: (context, index) {
                                        final expense =
                                            widget.expenseList[index];

                                        return ExpenseCard(
                                          title: expense.title,
                                          date: expense.date,
                                          amount: expense.amount,
                                          category: expense.category,
                                          description: expense.description,
                                          time: expense.time,
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
