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
}
