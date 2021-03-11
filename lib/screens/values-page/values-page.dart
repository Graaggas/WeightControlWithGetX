import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/misc/converters.dart';
import 'package:weight_control/screens/values-page/controller.dart';
import 'package:weight_control/screens/values-page/weight-card.dart';

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
        () => SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Text"),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: valuesController.itemCounter.value,
                itemBuilder: (BuildContext context, int index) {
                  return WeightCard(
                    weightText: valuesController.listWeights[index].toString(),
                    dateText: convertFromDateTimeToString(
                        valuesController.listDateTimes[index]),
                  );
                  // DateTime key = mapWeights.entries.elementAt(1).key;
                  //logger.e("key = $key");
                  // return ListTile(
                  //   title: Text(
                  //       "${valuesController.listWeights[index].toString()}"),
                  //   subtitle: Text("${convertFromDateTimeToString(
                  //       valuesController.listDateTimes[index])}"),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
