import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/screens/values-page/controller.dart';

class ValuesPage extends StatelessWidget {
  final ValuesController valuesController = Get.put(ValuesController());
  final logger = Logger();



  @override
  Widget build(BuildContext context) {
    valuesController.getInfoForWeightAtValuesPage();




    return Scaffold(
      appBar: AppBar(
        title: Text("Замеры"),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: valuesController.itemCounter.value,
            itemBuilder: (BuildContext context, int index) {
              // DateTime key = mapWeights.entries.elementAt(1).key;
              //logger.e("key = $key");
              return ListTile(
                  title: Text("${valuesController.listWeights[index].toString()}"),
                  subtitle: Text("${valuesController.listDateTimes[index].toString()}"),
                  );
            }),
      ),
    );
  }
}
