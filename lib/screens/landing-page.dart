import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'package:weight_control/screens/first-meeting/first-meeting-controller.dart';
import 'package:weight_control/screens/first-meeting/first-meeting.dart';
import 'package:weight_control/screens/home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirstMeetingController firstMeetingController =
    Get.put(FirstMeetingController());
    // bool flag = false;
    // final ControllerDashboardInfo controllerDashboardInfo = Get.put(ControllerDashboardInfo());
  //   firstMeetingController.getFlag().then((value)  {
  //   flag = value;
  //   print("then, flag=$flag");
  // });
  //   print("flag in main : $flag");
  //
  //   return flag == true
  //   ? FirstMeeting()
  //       : HomePage(
  //   );

    return FutureBuilder<bool>(
        future: firstMeetingController.getFlag(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot = ${snapshot.data}");

            return snapshot.data == true ? FirstMeeting() : HomePage();
          } else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }
}
