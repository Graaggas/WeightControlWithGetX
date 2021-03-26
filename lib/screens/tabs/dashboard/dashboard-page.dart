import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:weight_control/misc/constants.dart';
import 'package:weight_control/misc/radial-progress.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class DashboardPage extends StatelessWidget {
  final ControllerDashboardInfo controllerDashboardInfo =
      Get.put(ControllerDashboardInfo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorMain),
      appBar: AppBar(
        title: Text(
          "Прогресс",
          style: GoogleFonts.robotoSlab(
            // fontWeight: FontWeight.bold,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              StartWeightWidget(),
              SizedBox(
                height: 20,
              ),
              StartWaisteWidget(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Сводная информация",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "по весу",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildGridWeight(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Сводная информация",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "по объему талии",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildGridWaiste(),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildGridWeight() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      childAspectRatio: 2.0,
      padding: EdgeInsets.all(10.0),
      children: [
        buildCardForAverage("7 дней (кг)", true, 3.0),
        buildCardForAverage("30 дней (кг)", false, 3.0),
        buildCardForAverage("Все время (кг)", false, 3.0),
        buildCardForAverage("Среднее (кг)", false, 3.0),
      ],
    );
  }

  GridView buildGridWaiste() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      childAspectRatio: 2.0,
      padding: EdgeInsets.all(10.0),
      children: [
        buildCardForAverage("7 дней (см)", false, 102),
        buildCardForAverage("30 дней (см)", false, 13),
        buildCardForAverage("Все время (см)", false, 11.7),
        buildCardForAverage("Среднее (см)", false, 3),
      ],
    );
  }

  Card buildCardForAverage(String averageValue, bool isUpArrow, double value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      color: Color(colorContainerWithStartEndValuesWaist),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  averageValue,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: isUpArrow
                        ? Icon(
                            LineAwesomeIcons.arrow_up,
                            color: Colors.red,
                          )
                        : Icon(
                            LineAwesomeIcons.arrow_down,
                            color: Colors.green,
                          ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "${value.toString()}",
                          presetFontSizes: [60, 40, 20, 10],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
          ],
        ),
      ),
    );
  }
}

class StartWaisteWidget extends StatelessWidget {
  const StartWaisteWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildStartAndFinishContainer(
                mainColor: myColorCardDashboardWeightThree,
                typeOfValueWeightWaiste: "объем",
                isWeight: false),
          ),
          Expanded(
            child: RadialProgress(
              typeOfMeasure: "см",
              isWeight: false,
            ),
          ),
        ],
      ),
    );
  }
}

class StartWeightWidget extends StatelessWidget {
  const StartWeightWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildStartAndFinishContainer(
                mainColor: myColorCardDashboardWeightOne,
                typeOfValueWeightWaiste: "вес",
                isWeight: true),
          ),
          Expanded(
            child: RadialProgress(isWeight: true, typeOfMeasure: "кг"),
          ),
        ],
      ),
    );
  }
}

Column buildStartAndFinishContainer({
  Color mainColor,
  String typeOfValueWeightWaiste,
  bool isWeight,
}) {
  return Column(
    children: [
      Stack(
        children: <Widget>[
          Container(
            // margin: EdgeInsets.all(4),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: mainColor,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(100, 80),
              painter: WidgetValues(myColorCardDashboardWeightTwo),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Начальный",
                    style: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    typeOfValueWeightWaiste,
                    style: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            bottom: 0,
            right: 10,
            child: GetBuilder<ControllerDashboardInfo>(
              init: ControllerDashboardInfo(),
              builder: (controller) {
                return isWeight
                    ? Text(
                        "${controller.startWeight} кг",
                        style: GoogleFonts.russoOne(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        "111",
                        style: GoogleFonts.russoOne(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Stack(
        children: <Widget>[
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(8),
              // gradient: LinearGradient(
              //     colors: [Colors.lightBlue, Colors.blue],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.blue,
              //     blurRadius: 2,
              //     offset: Offset(0, 1),
              //   ),
              // ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(100, 80),
              painter: WidgetValues(myColorCardDashboardWeightTwo),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  isWeight
                      ? Text(
                          "Желаемый",
                          style: GoogleFonts.robotoSlab(
                            // fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "Требуемый",
                          style: GoogleFonts.robotoSlab(
                            // fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    typeOfValueWeightWaiste,
                    style: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            bottom: 0,
            right: 10,
            child: GetBuilder<ControllerDashboardInfo>(
              init: ControllerDashboardInfo(),
              builder: (controller) {
                return isWeight
                    ? Text(
                        "${controller.wantedWeight} кг",
                        style: GoogleFonts.russoOne(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        "222",
                        style: GoogleFonts.russoOne(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    ],
  );
}

class WidgetValues extends CustomPainter {
  var startColor;

  WidgetValues(this.startColor);

  var endColor = Colors.redAccent;
  var radius = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    //paint..color = startColor;
    paint.shader =
        ui.Gradient.linear(Offset(0, 0), Offset(size.width, size.height), [
      startColor,
      startColor,
      //HSLColor.fromColor(myColorCardDashboardOne).toColor(),
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - radius * 3, 0)
      ..quadraticBezierTo(-radius, size.height / 2, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.grey.withAlpha(50), 2, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
