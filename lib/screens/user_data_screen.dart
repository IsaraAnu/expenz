import 'package:expenz/constants/colors.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  // remember me for the next time
  bool _rememberMe = false;

  // fomr key for form validation
  final _formKey = GlobalKey<FormState>();

  // controllers for the text form validations
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController
        .dispose(); // this method i mean dispose method remove the memory when we go the next page
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 30),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form field for the user name
                      TextFormField(
                        validator: (value) {
                          //check weather the user enter the valid user name
                          if (value!.isEmpty) {
                            return 'Please Enter your name';
                          }
                        },
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 20),

                      // user email form field
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 20),

                      // user password form field
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 20),
                      // user confirm password form field
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please confirm your password";
                          }
                        },
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 25),
                      //remember me for the next time
                      Row(
                        children: [
                          Text(
                            'Remember Me for the next time',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Switch(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      //submit button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // form is valid .process the data
                            String userName = _userNameController.text;
                            String useEmail = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            print(
                              "$userName $useEmail $password $confirmPassword",
                            );
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
