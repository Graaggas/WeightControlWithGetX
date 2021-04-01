import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_control/misc/converters.dart';
import 'package:weight_control/screens/first-meeting/first-meeting-controller.dart';
import 'package:weight_control/screens/home-page/home_page.dart';

class FirstMeeting extends StatelessWidget {
  final textStartWeightController = TextEditingController();
  final textWantedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final ControllerDashboardInfo controllerDashboardInfo = Get.find();
    final FirstMeetingController firstMeetingController = Get.find();

    final pages = [
      Container(
        color: Colors.red,
        child: Center(child: Text("1")),
      ),
      Container(
        color: Colors.teal,
        child: Center(child: Text("2")),
      ),
    ];

    return Scaffold(
      // body: Center(
      //   child: OutlinedButton(
      //     onPressed: () {
      //       controllerDashboardInfo.flagFirstMeeting.value = false;
      //     },
      //     child: Text("push"),
      //   ),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Введите начальные значения"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textStartWeightController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                ],
                keyboardType: TextInputType.number,
                // key: waisteTextFieldKey,
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Текущий вес',
                  // enabled: checkController.getWaisteChecking
                  //     ? true
                  //     : false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textWantedController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                ],
                keyboardType: TextInputType.number,
                // key: waisteTextFieldKey,
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Желаемый вес',
                  // enabled: checkController.getWaisteChecking
                  //     ? true
                  //     : false,
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 4,
                primary: Colors.white,
                backgroundColor: Colors.redAccent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () async {
                await firstMeetingController.putInitWeight(
                    startWeight1:
                        convertDoubleToString(textStartWeightController.text),
                    wantedWeight1:
                        convertDoubleToString(textWantedController.text));
                await firstMeetingController.changeFlagFirstMeeting();
                Get.off(() => HomePage());
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32,
                  top: 8,
                  bottom: 8,
                ),
                child: Text(
                  "Добавить",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
