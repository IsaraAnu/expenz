import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<void> storeUserDetails({
    required String userName,
    required String Email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      // check weather the user entered password and confirm password as same or not
      if (password != confirmPassword) {
        // show massage to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password and Confirm Password is not match!"),
          ),
        );
        return;
      }
      // if the password and conf password are same then store the userName and email
      // create an instant for shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the username and email as key value pair
      await prefs.setString("userName", userName);
      await prefs.setString("email", Email);

      //show message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User Name and Email are Saved Successfully!")),
      );
    } catch (err) {
      err.toString();
    }
  }
}
