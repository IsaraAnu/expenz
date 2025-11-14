import 'package:expenz/constants/colors.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/widgets/icome_expence_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the usernam
  String username = "";

  @override
  void initState() {
    //get the username from the shared pref
    UserServices.getUserData().then((value) {
      if (value["userName"] != null) {
        setState(() {
          username = value["userName"]!;
        });
      }
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
                            amount: 1200,
                            imageUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IcomeExpenceCard(
                            title: "Expence",
                            amount: 500,
                            imageUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
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
