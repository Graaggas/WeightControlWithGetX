import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:weight_control/misc/constants.dart';
import 'package:weight_control/misc/converters.dart';

import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class WeightCard extends StatelessWidget {
  final DateTime dateTime;
  final int index;
  final double weight;

  const WeightCard({
    Key key,
    this.dateTime,
    this.weight,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo = Get.find();

    print("weight in card : $weight");
    print("date in card : $dateTime");
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: myColorCardDashboardWeightOne,
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controllerDashboardInfo.weightsList[index]} кг",
                                  style: GoogleFonts.russoOne(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${convertFromDateTimeToString(controllerDashboardInfo.datesList[index])}",
                                  style: GoogleFonts.robotoSlab(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text("${convertFromDateTimeToString(dateTime)}"),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: CustomPaint(
                size: Size(110, 100),
                painter: Painting(myColorCardDashboardWeightTwo),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.black87,
                    ),
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
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black87,
                    ),
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
                          duration: Duration(seconds: 1),
                          content: Text('Запись \'$weight кг\' удалена'),
                          elevation: 4,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Painting extends CustomPainter {
  var radius = 8.0;
  var endColor = Colors.redAccent;
  var startColor;
  Painting(this.startColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paintCanvas = Paint();

    paintCanvas.shader =
        ui.Gradient.linear(Offset(0, 0), Offset(size.width, size.height), [
      startColor,
      endColor,
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - radius * 8, 0)
      ..quadraticBezierTo(-radius, size.height / 2, 0, size.height)
      ..close();

    canvas.drawPath(path, paintCanvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
