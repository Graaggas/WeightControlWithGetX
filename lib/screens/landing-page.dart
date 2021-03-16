import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'file:///C:/FlutterProjects/fromAndroidStudio/weight_control/lib/screens/first-meeting/first-meeting.dart';
import 'package:weight_control/screens/home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo =
        Get.put(ControllerDashboardInfo());

    return Obx(() => controllerDashboardInfo.flagFirstMeeting.value
        ? FirstMeeting()
        : HomePage());
  }
}
