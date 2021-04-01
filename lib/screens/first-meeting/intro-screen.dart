import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen_bottom_navigation_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:weight_control/screens/first-meeting/first-meeting-controller.dart';
import 'package:weight_control/screens/first-meeting/first-meeting.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController;
  List<Widget> slideList;
  int initialPage;


  @override
  void initState() {
    _pageController = PageController(initialPage: 2);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GFIntroScreen(
        color: Colors.blueGrey,
        slides: [
          Container(
            child: Scaffold(body: Center(child: Text("111"))),
          ),
          Container(
            child: Scaffold(body: Center(child: Text("222"))),
          ),
          Container(
            child: Scaffold(body: Center(child: Text("333"))),
          ),
        ],
        pageController: _pageController,
        currentIndex: 0,
        pageCount: 3,
        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
          forwardButton: Icon(Boxicons.bx_right_arrow),
          skipButtonText: "ОТМЕНА",
          backButton: Icon(Boxicons.bx_left_arrow),
          doneButtonText: "OK",
          onDoneTap: () {
            Get.off(() => FirstMeeting());
          },
          pageController: _pageController,
          pageCount: 3,
          currentIndex: initialPage,
          onForwardButtonTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          onBackButtonTap: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          navigationBarColor: Colors.white,
          showDivider: false,
          inactiveColor: Colors.grey[200],
          activeColor: GFColors.SUCCESS,
        ),
      ),
    );
  }
}
