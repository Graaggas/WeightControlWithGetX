import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weight_control/misc/constants.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';


class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorMain),
      appBar: AppBar(
        title: Text("Прогресс"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // child: Text(
                //   "Прогресс",
                //   style: TextStyle(
                //     fontSize: 26,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              color:
                              Color(colorContainerWithStartEndValuesWeight),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   LineAwesomeIcons.arrow_circle_up,
                                    //   color: Colors.red,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Начальный вес"),
                                          GetBuilder<ControllerDashboardInfo>(
                                            init: ControllerDashboardInfo(),
                                            builder: (controller) {
                                              return Text(
                                                "${controller.startWeight} кг",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              color:
                              Color(colorContainerWithStartEndValuesWeight),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   LineAwesomeIcons.arrow_circle_down,
                                    //   color: Colors.green,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Желаемый вес"),
                                         GetBuilder<ControllerDashboardInfo>(
                                           init: ControllerDashboardInfo(),
                                              builder:(controller) {
                                                return Text(
                                                  "${controller.wantedWeight} кг",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 150,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.15,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                              showTicks: false,
                              showLabels: false,
                              onAxisTapped: (value) {},
                              pointers: <GaugePointer>[
                                RangePointer(
                                  enableAnimation: true,
                                  color: Colors.red[400],
                                  value: 13,
                                  onValueChanged: (value) {},
                                  cornerStyle: CornerStyle.bothCurve,
                                  onValueChangeEnd: (value) {},
                                  onValueChanging: (value) {},
                                  enableDragging: false,
                                  width: 0.15,
                                  sizeUnit: GaugeSizeUnit.factor,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text("Сейчас"),

                                          GetBuilder(builder: (
                                              ControllerDashboardInfo controller) {
                                            return Text(
                                              // "${controller.listWeights[controller.itemCounter.value-1]}",
                                              "${controller.currentWeight}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }),

                                        ],
                                      ),
                                      Text("-13 кг"),
                                    ],
                                  ),
                                  positionFactor: 0.05,
                                  // angle: 0.5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              color:
                              Color(colorContainerWithStartEndValuesWaist),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   LineAwesomeIcons.arrow_circle_up,
                                    //   color: Colors.red,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Начальный объем"),
                                          Text(
                                            "120 см",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              color:
                              Color(colorContainerWithStartEndValuesWaist),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   LineAwesomeIcons.arrow_circle_down,
                                    //   color: Colors.green,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Желаемый объем"),
                                          Text(
                                            "90 см",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 150,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.15,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                              showTicks: false,
                              showLabels: false,
                              onAxisTapped: (value) {},
                              pointers: <GaugePointer>[
                                RangePointer(
                                  enableAnimation: true,
                                  color: Colors.blue[300],
                                  value: 48,
                                  onValueChanged: (value) {},
                                  cornerStyle: CornerStyle.bothCurve,
                                  onValueChangeEnd: (value) {},
                                  onValueChanging: (value) {},
                                  enableDragging: false,
                                  width: 0.15,
                                  sizeUnit: GaugeSizeUnit.factor,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text("Сейчас"),
                                          ),
                                          Text(
                                            "120",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("-13 см"),
                                    ],
                                  ),
                                  positionFactor: 0.05,
                                  // angle: 0.5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
