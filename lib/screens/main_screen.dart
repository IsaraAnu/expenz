import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/icnome_model.dart';
import 'package:expenz/screens/add_new.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expence_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //int to track current index
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  // function to fetch expenses from add new screen
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpensesServices().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  // function to fetch incomes from add new screen
  void fetchAllIncome() async {
    List<Income> loadedIncome = await IncomeServices().LoadIncome();
    setState(() {
      incomeList = loadedIncome;
    });
  }

  // function to add new expense
  void addNewExpense(Expense newExpense) {
    ExpensesServices().saveExpenses(newExpense, context);

    // update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // function to add new income
  void addNewIncome(Income newIncome) {
    IncomeServices().saveIncome(newIncome, context);

    // update the list of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncome();
    });
  }

  //  function to handle dismissed expense
  void removeExpense(Expense expense) {
    ExpensesServices().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  // function to handle dismissed income
  void removeIncome(Income income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  // expense category total
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotals = {
      ExpenseCategory.food: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.subscription: 0,
      ExpenseCategory.transport: 0,
    };

    for (Expense expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }
    return categoryTotals;
  }

  // income category total
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.salary: 0,
      IncomeCategory.sales: 0,
    };

    for (Income income in incomeList) {
      categoryTotals[income.category] =
          categoryTotals[income.category]! + income.amount;
    }
    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      HomeScreen(expenseList: expenseList, incomesList: incomeList),
      TransactionScreen(
        expensesList: expenseList,
        onDissmissedExpense: removeExpense,
        incomesList: incomeList,
        onDissmissedIncome: removeIncome,
      ),
      AddNewScreen(addExpese: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(
        expenseCategoryTotal: calculateExpenseCategories(),
        incomeCategoryTotal: calculateIncomeCategories(),
      ),

      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        backgroundColor: kWhite,
        selectedLabelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),

              child: Icon(Icons.add, color: kWhite, size: 50),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: "Budget",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
