import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:get/get.dart';
import 'package:weight_control/model/weight/waiste_model.dart';


import 'package:weight_control/model/weight/weight_model.dart';


import 'package:weight_control/screens/landing-page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(WeightModelAdapter());
  Hive.registerAdapter(WaisteModelAdapter());
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  //final ControllerDashboardInfo controllerWeight = Get.put(ControllerDashboardInfo());




  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home:  LandingPage(),
    );
  }
}
