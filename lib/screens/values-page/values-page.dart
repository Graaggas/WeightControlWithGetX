import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

import 'package:weight_control/screens/values-page/weight-card.dart';

class ValuesWeightsPage extends StatelessWidget {
  final logger = Logger();

  final ControllerDashboardInfo controller = Get.put(ControllerDashboardInfo());


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Замеры"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Показания весов"),
            Obx(
              () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.itemCounter.value,
                  itemBuilder: (context, index) {
                    return WeightCard(
                      weight: controller.weightsList[index],
                      dateTime: controller.datesList[index],
                      index: index,
                    );
                  }),
            ),
           OutlinedButton(onPressed: (){
             print(controller.flagFirstMeeting.value.toString());
           }, child: Text("press")),
          ],
        ),
      ),
    );
  }
}
