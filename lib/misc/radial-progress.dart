import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:weight_control/misc/constants.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class RadialProgress extends StatelessWidget {
  final String typeOfMeasure;
  final bool isWeight;

  const RadialProgress({Key key, this.typeOfMeasure, this.isWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo = Get.find();

    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Obx(
            () => CustomPaint(
              size: Size(
                200,
                200,
              ),
              painter: isWeight
                  ? RadialPainter(
                      angle: controllerDashboardInfo.angleWeight.value)
                  : RadialPainter(
                      angle: controllerDashboardInfo.angleWaiste.value),
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Сейчас",
                  style: GoogleFonts.robotoSlab(
                    // fontWeight: FontWeight.bold,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                isWeight
                    ? Text(
                        "${controllerDashboardInfo.currentWeight.value.toString()}",
                        style: GoogleFonts.russoOne(
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "${controllerDashboardInfo.currentWaiste.value.toString()}",
                        style: GoogleFonts.russoOne(
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                isWeight
                    ? RichText(
                        text: TextSpan(
                          style: GoogleFonts.russoOne(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                          children: <TextSpan>[
                            controllerDashboardInfo
                                        .currentIsFirstInListWeight.value ==
                                    false
                                ? TextSpan(
                                    text: controllerDashboardInfo
                                                .getDiffCurrentPrevoius() <
                                            0
                                        ? "${controllerDashboardInfo.getDiffCurrentPrevoius().toStringAsFixed(2)} "
                                        : "+${controllerDashboardInfo.getDiffCurrentPrevoius().abs().toStringAsFixed(2)} ",
                                  )
                                : TextSpan(text: ""),
                            TextSpan(
                              text: typeOfMeasure,
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: GoogleFonts.russoOne(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: ""),
                            TextSpan(
                              text: typeOfMeasure,
                            ),
                          ],
                        ),
                      ),
                // Text(
                //   "-12 кг",
                //   style: GoogleFonts.russoOne(
                //     // fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //     color: Colors.white60,
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            left: 8,
            child: Icon(
              Boxicons.bx_right_arrow,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  final angle;

  RadialPainter({this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 3, paint);

    Paint paintProgress = Paint()
      ..color = myColorCardWeightDashboardProgressFilling
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 3),
        math.radians(-180), math.radians(angle), false, paintProgress);

    Paint paintInnerCircle = Paint()
      ..shader = ui.Gradient.radial(
          center, 100.0, [Colors.red, myColorCardDashboardWeightTwo])
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 30;

    canvas.drawCircle(center, size.width / 3 - 6, paintInnerCircle);
    print("||RADIAL-PROGRESS|| angle = $angle\n\n");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
