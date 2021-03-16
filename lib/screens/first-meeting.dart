import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class FirstMeeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo = Get.find();

    return Scaffold(
      // body: Center(
      //   child: OutlinedButton(
      //     onPressed: () {
      //       controllerDashboardInfo.flagFirstMeeting.value = false;
      //     },
      //     child: Text("push"),
      //   ),
      // ),

      body:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Текущий вес"),
                SizedBox(height: 20,),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^\d+\.?\d{0,2}"))
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
                SizedBox(height: 20,),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^\d+\.?\d{0,2}"))
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
                SizedBox(height: 20,),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 4,
                    primary: Colors.white,
                    backgroundColor: Colors.redAccent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {

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
