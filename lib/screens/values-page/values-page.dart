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

          ],
        ),
      ),
    );
  }
}

//TODO 1. При удалении всех значений остается ноль в списке весов. Убрать.
// TODO 2. При удалении всех значений весов "начальный вес" зануляется и при добавлении весов остается нулевым
//TODO 3. При первом запуске после ввода (не работает еще) первоначальных данных в списке значений отображается дубль.
//TODO 4. На странице ввода первоначальных значений сделать считывание из полей.