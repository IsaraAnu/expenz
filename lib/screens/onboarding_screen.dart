import 'package:expenz/constants/colors.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screens.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController _controller = PageController();
  bool showDetailedPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // onboading screen setup
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                showDetailedPage = index == 3;
              });
            },
            children: [
              FrontPage(),
              sharedOnboardingWidget(
                title: OnboardingData.onboardingDataList[0].title,
                description: OnboardingData.onboardingDataList[0].description,
                imagePath: OnboardingData.onboardingDataList[0].imagePath,
              ),
              sharedOnboardingWidget(
                title: OnboardingData.onboardingDataList[1].title,
                description: OnboardingData.onboardingDataList[1].description,
                imagePath: OnboardingData.onboardingDataList[1].imagePath,
              ),
              sharedOnboardingWidget(
                title: OnboardingData.onboardingDataList[2].title,
                description: OnboardingData.onboardingDataList[2].description,
                imagePath: OnboardingData.onboardingDataList[2].imagePath,
              ),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.5),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: WormEffect(
                activeDotColor: kMainColor,
                dotColor: kLightGrey,
              ),
            ),
          ),
          //navigation button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: !showDetailedPage
                  ? GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          _controller.page!.toInt() + 1,
                          duration: Duration(microseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: CustomButton(
                        buttonName: showDetailedPage ? "Get Started" : "Next",
                        buttonColor: kMainColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDataScreen(),
                          ),
                        );
                      },
                      child: CustomButton(
                        buttonName: showDetailedPage ? "Get Started" : "Next",
                        buttonColor: kMainColor,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
