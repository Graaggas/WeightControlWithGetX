import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'package:weight_control/screens/tabs/addingPage/adding-values.dart';
import 'file:///C:/FlutterProjects/fromAndroidStudio/weight_control/lib/screens/tabs/dashboard-page.dart';
import 'package:weight_control/screens/tabs/graphics-page.dart';

import 'package:weight_control/screens/tabs/info-page.dart';

import 'package:weight_control/screens/values-page/values-page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  List<Widget> screens = [
    DashboardPage(),
    GraphicsPage(),
    ValuesWeightsPage(),
    InfoPage(),
  ];

  Widget currentScreen = DashboardPage();
  final PageStorageBucket bucket = PageStorageBucket();
  final ControllerDashboardInfo controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final ControllerDashboardInfo controllerDashboardInfo = Get.find();

    controllerDashboardInfo.init();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => AddingValuesPage.show(context),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = DashboardPage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0
                              ? Colors.deepPurple
                              : Colors.white,
                        ),
                        Text(
                          "Прогресс",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.deepPurple
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = GraphicsPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LineAwesomeIcons.area_chart,
                          color: currentTab == 1
                              ? Colors.deepPurple
                              : Colors.white,
                        ),
                        Text(
                          "Графики",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.deepPurple
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ValuesWeightsPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.table_rows,
                          color: currentTab == 2
                              ? Colors.deepPurple
                              : Colors.white,
                        ),
                        Text(
                          "Вес",
                          style: TextStyle(
                            color: currentTab == 2
                                ? Colors.deepPurple
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = InfoPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.info,
                          color: currentTab == 3
                              ? Colors.deepPurple
                              : Colors.white,
                        ),
                        Text(
                          "Данные",
                          style: TextStyle(
                            color: currentTab == 3
                                ? Colors.deepPurple
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [Colors.blue, Colors.red[300]], begin: Alignment.topLeft, end: Alignment.bottomRight),
        // ),
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
    );
  }
}
