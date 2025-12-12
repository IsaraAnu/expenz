import 'dart:convert';

import 'package:expenz/models/expence_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesServices {
  //define a key for store the data in shared preferences
  static const String _expenseKey = 'expenses';

  // save the expenses to the shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? exsitstingExpenses = prefs.getStringList(_expenseKey);

      // convert the expenses string to the expenses objects
      List<Expense> existingExpensesObjects = [];

      if (exsitstingExpenses != null) {
        existingExpensesObjects = exsitstingExpenses
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }

      // add the new expense to the existing expenses
      existingExpensesObjects.add(expense);

      // conver the list of expense objects to list of strings
      List<String> updatedExpenses = existingExpensesObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated expenses list to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving expense. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expenses from shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    // Convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJson(json.decode(e)))
          .toList();
    }

    // Return the list of loaded expenses
    return loadedExpenses;
  }

  // delete an expense from shared preferences by its id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      // create a instanse of shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      // create the list of expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }
      // remove the expense with the given id
      existingExpenseObjects.removeWhere((expense) => expense.id == id);

      // convert the updated list of expense objects to list of strings
      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated expenses list to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error of deleting expense: ${error.toString()}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error deleting expense. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // delete all the expenses from the sharedpreferences
  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expenseKey);

      //show a massage
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All Expenses Deleted!.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Expenses deleting!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
