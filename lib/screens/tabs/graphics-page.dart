import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_control/misc/chart.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';

class GraphicsPage extends StatelessWidget {
  final ControllerDashboardInfo controllerDashboardInfo = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text(
          "Графики",
          style: GoogleFonts.robotoSlab(
            // fontWeight: FontWeight.bold,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Chart(
                text: "Показания веса",
                list: controllerDashboardInfo.chartWeights,
                startValue: controllerDashboardInfo.startWeight.value,
                wantedValue: controllerDashboardInfo.wantedWeight.value,
              ),
            ),
            Container(
              child: Chart(
                text: "Показания объема",
                list: controllerDashboardInfo.chartWaiste,
                startValue: controllerDashboardInfo.startWaiste.value,
                wantedValue: controllerDashboardInfo.wantedWaiste.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
