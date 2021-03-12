import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_control/misc/converters.dart';
import 'package:weight_control/screens/values-page/controller.dart';

class WeightCard extends StatelessWidget {
  final DateTime dateTime;
  final ValuesController valuesController;
  final double weight;

  const WeightCard(
      {Key key, this.dateTime, this.valuesController, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // valuesController.getWeightInCard(dateTime);

    print("weight in card : $weight");
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
                  Text(
                    "$weight кг",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${convertFromDateTimeToString(dateTime)}"),
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

                       if(res != null) {
                         print("new value = $res");
                         valuesController.changeOneWeight(double.parse(res[0]), dateTime);
                         valuesController.getInfoForWeightAtValuesPage();
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
                        valuesController.deleteWeight(dateTime);
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
