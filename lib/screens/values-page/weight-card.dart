import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:weight_control/misc/converters.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class WeightCard extends StatelessWidget {
  final DateTime dateTime;
  final int index;
  final double weight;

  const WeightCard({
    Key key,
    this.dateTime,
    this.weight, this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo = Get.find();

    print("weight in card : $weight");
    print("date in card : $dateTime");
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "${controllerDashboardInfo.weightsList[index]} кг",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text("${convertFromDateTimeToString(dateTime)}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () async {
                      var res = await showTextInputDialog(
                          context: context,
                          title: "Изменение показания веса",
                          textFields: [
                            DialogTextField(
                              initialText: "$weight",
                              keyboardType: TextInputType.number,
                            ),
                          ]);

                      if (res != null) {
                        print(
                            "new value in widget card = $res , type = ${res.runtimeType}");
                        controllerDashboardInfo.updateOneWeight(
                            double.parse(res[0]), dateTime);
                      }
                    }),
                // SizedBox(width: 5,),
                IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () async {
                      var res = await showOkCancelAlertDialog(
                        context: context,
                        message: "Удалить запись \'$weight кг'\ ?",
                        okLabel: "Удалить",
                        alertStyle: AdaptiveStyle.material,
                        // defaultType: OkCancelAlertDefaultType.cancel,
                        cancelLabel: "Отмена",
                        // title: "Title",
                      );
                      if (res == OkCancelResult.ok) {
                        // valuesController.deleteWeight(dateTime);
                        controllerDashboardInfo.deleteWeight(dateTime);

                        final snackBar = SnackBar(
                          content: Text('Запись \'$weight кг\' удалена'),
                          elevation: 4,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
