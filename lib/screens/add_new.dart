import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/icnome_model.dart';
import 'package:expenz/services/expence_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpese;
  final Function(Income) addIncome;
  const AddNewScreen({
    super.key,
    required this.addExpese,
    required this.addIncome,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  // state to track the click on expence or income
  int _selectedMethod = 0;

  // store the category data
  ExpenseCategory _expenseCategory = ExpenseCategory.food;
  IncomeCategory _incomeCategory = IncomeCategory.salary;

  // textediting controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // store the selected date and time
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  // dispose the controllers data
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kWhite,
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
                            color: _selectedMethod == 0 ? kMainColor : kWhite,
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
                            color: _selectedMethod == 1 ? kMainColor : kWhite,
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
              // amount field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How Much?",
                        style: TextStyle(
                          color: kLightGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: TextStyle(
                            color: kWhite,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // user data form
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                ),

                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        // category select dropdown
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: kDefaultFontSize,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          items: _selectedMethod == 0
                              ? ExpenseCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList()
                              : IncomeCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),

                          value: _selectedMethod == 0
                              ? _expenseCategory
                              : _incomeCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedMethod == 0
                                  ? _expenseCategory = value as ExpenseCategory
                                  : _incomeCategory = value as IncomeCategory;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // title field
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // description field
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // amount field
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // date picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  initialDate: DateTime.now(),
                                  context: context,
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime(2030),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedDate = value;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // time picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kYellow,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        fontWeight: FontWeight.w600,
                                        Icons.access_time,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(_selectedTime),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // devider
                        Divider(color: kLightGrey, thickness: 6),
                        const SizedBox(height: 10),
                        // submit button
                        GestureDetector(
                          onTap: () async {
                            // save the income or expense data to the shared preferences
                            if (_selectedMethod == 0) {
                              // adding expenses

                              List<Expense> loadedExpenses =
                                  await ExpensesServices().loadExpenses();

                              // create a expense to store the data
                              Expense expense = Expense(
                                id: loadedExpenses.length + 1,
                                title: _titleController.text,
                                amount: _amountController.text.isEmpty
                                    ? 0
                                    : double.parse(_amountController.text),
                                category: _expenseCategory,
                                date: _selectedDate,
                                time: _selectedTime,
                                description: _descriptionController.text,
                              );

                              // add expeses
                              widget.addExpese(expense);

                              // clear the fields
                              _titleController.clear();
                              _amountController.clear();
                              _descriptionController.clear();
                            } else {
                              // adding income
                              List<Income> loadedIncome = await IncomeServices()
                                  .LoadIncome();
                              // create income object
                              Income income = Income(
                                id: loadedIncome.length + 1,
                                title: _titleController.text,
                                amount: _amountController.text.isEmpty
                                    ? 0
                                    : double.parse(_amountController.text),
                                category: _incomeCategory,
                                date: _selectedDate,
                                time: _selectedTime,
                                description: _descriptionController.text,
                              );

                              // save income to shared preferences
                              widget.addIncome(income);

                              // clear the fields
                              _titleController.clear();
                              _amountController.clear();
                              _descriptionController.clear();
                            }
                          },
                          child: CustomButton(
                            buttonName: "Add",
                            buttonColor: _selectedMethod == 0 ? kRed : kGreen,
                          ),
                        ),
                      ],
                    ),
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
