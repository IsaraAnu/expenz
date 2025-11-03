import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class sharedOnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  const sharedOnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(imagePath, width: 300, fit: BoxFit.cover),
          SizedBox(height: 18),
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: kBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            description,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
