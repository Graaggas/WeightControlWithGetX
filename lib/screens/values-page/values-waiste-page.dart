import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'package:weight_control/screens/values-page/waiste-card.dart';

class ValuesWaistePage extends StatelessWidget {
  final ControllerDashboardInfo controller = Get.put(ControllerDashboardInfo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text(
          "Замеры окружности талии",
          style: GoogleFonts.robotoSlab(
            // fontWeight: FontWeight.bold,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.itemCounterWaiste.value,
                  itemBuilder: (context, index) {
                    return WaisteCard(
                      waiste: controller.waisteList[index],
                      dateTime: controller.datesOfWaisteList[index],
                      index: index,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
