import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/screen1.dart';
import '../screens/screen2.dart';
import '../screens/screen3.dart';

import 'home_page.dart'; // Import your homepage class

class StartUpScreens extends StatefulWidget {
  const StartUpScreens({super.key});

  @override
  State<StartUpScreens> createState() => _StartUpScreensState();
}

class _StartUpScreensState extends State<StartUpScreens> {
  PageController pageController = PageController();
  String buttonText = "Skip";
  int currentPageIndex = 0;

  void navigateToHome() {
    // Navigate to Homepage when Skip or Finish is clicked
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()), // Your Homepage widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                // Change button text based on the page index
                buttonText = index == 2 ? "Finish" : "Skip"; // Show Finish at last page
              });
            },
            controller: pageController,
            children: [
              Screen1(),
              Screen2(),
              Screen3(),
            ],
          ),
          // Centered at the bottom of the screen
          Positioned(
            bottom: 0, // Ensures the Container is at the bottom of the screen
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(70), // Add some padding at the bottom
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
                children: [
                  // Skip button, only visible on the first two pages
                  Visibility(
                    visible: currentPageIndex != 2,
                    child: GestureDetector(
                      onTap: navigateToHome,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Space between Skip and the Page Indicator

                  // Page Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20), // Space between Page Indicator and Next/Finish button

                  // Next or Finish button
                  GestureDetector(
                    onTap: currentPageIndex == 2 ? navigateToHome : () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(
                      currentPageIndex == 2 ? "Finish" : "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
