import 'dart:convert';

import 'package:expenz/models/icnome_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices {
  // key to access the shared preferences
  static const String _incomeKey = 'income';

  // method to add an income service
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      // get the shared preferences instance
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingIncome = pref.getStringList(_incomeKey);

      // convert the income string to the income objects
      List<Income> existingIncomeObjects = [];

      if (exsistingIncome != null) {
        existingIncomeObjects = exsistingIncome
            .map((e) => Income.fromJson(json.decode(e)))
            .toList();
      }

      // add the new income to the existing income
      existingIncomeObjects.add(income);

      // convert the list of income objects to list of strings(json format)
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated income list to shared preferences
      await pref.setStringList(_incomeKey, updatedIncome);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Income added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving income. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // method to load income from shared preferences
  Future<List<Income>> LoadIncome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? exsistingIncome = pref.getStringList(_incomeKey);

    // convert the existing income to a list of Income objects
    List<Income> loadedIncome = [];

    if (exsistingIncome != null) {
      loadedIncome = exsistingIncome
          .map((e) => Income.fromJson(json.decode(e)))
          .toList();
    }
    return loadedIncome;
  }

  // delete an income from shared preferences by its id
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      // create instance of shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncome = prefs.getStringList(_incomeKey);

      // convert the existing income to a list of Income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncome != null) {
        existingIncomeObjects = existingIncome
            .map((e) => Income.fromJson(json.decode(e)))
            .toList();
      }
      // remove the income with the given id
      existingIncomeObjects.removeWhere((Income) => Income.id == id);

      // convert the updated list of income objects to list of strings
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated income list to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income deleted successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error deleting income. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // delete all the incomes from the sharedpreferences
  Future<void> deleteAllIncomes(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_incomeKey);

      //show a massage
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All Incomes Deleted!.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Incomes deleting!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
