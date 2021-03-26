import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:weight_control/misc/constants.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class RadialProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var anglePerKg = 0.0;
    // var diff = 0.0;
    // var angle = 0.0;

    final ControllerDashboardInfo controllerDashboardInfo = Get.find();
    // diff = controllerDashboardInfo.startWeight.value - controllerDashboardInfo.currentWeight.value;
    // print("diff = $diff");
    //
    // anglePerKg = 360/(controllerDashboardInfo.startWeight.value - controllerDashboardInfo.wantedWeight.value);
    // print("anglePerKg = $anglePerKg");
    //
    // angle = diff * anglePerKg;

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
              painter: RadialPainter(
                  angle: controllerDashboardInfo.angleWeight.value),
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
                Text(
                  "${controllerDashboardInfo.currentWeight.value.toString()}",
                  style: GoogleFonts.russoOne(
                    // fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "-12 кг",
                  style: GoogleFonts.russoOne(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
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
      ..color = Colors.black12
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
      //..color = HSLColor.fromColor(Colors.red).withLightness(0.7).toColor()
      ..color = myColorCardDashboardWeightTwo
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 30;

    canvas.drawCircle(center, size.width / 3 - 6, paintInnerCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
