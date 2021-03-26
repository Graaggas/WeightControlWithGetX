import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'package:weight_control/screens/tabs/addingPage/checkController.dart';

var logger = Logger();

class AddingValuesPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddingValuesPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddingValuesPageState createState() => _AddingValuesPageState();
}

class _AddingValuesPageState extends State<AddingValuesPage> {
  final textWeightController = TextEditingController();

  final weightTextFieldKey = GlobalKey();
  final waisteTextFieldKey = GlobalKey();
  Size sizeWeightTextFieldKey = Size(0, 0);
  Size sizeWaisteTextFieldKey = Size(0, 0);

  void calculateSizes() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox boxWeightTextFieldKey =
          weightTextFieldKey.currentContext.findRenderObject();
      final RenderBox boxWaisteTextFieldKey =
          waisteTextFieldKey.currentContext.findRenderObject();

      setState(() {
        sizeWeightTextFieldKey = boxWeightTextFieldKey.size;
        sizeWaisteTextFieldKey = boxWaisteTextFieldKey.size;
      });
    });
  }

  @override
  void initState() {
    calculateSizes();
    super.initState();
  }

  @override
  void dispose() {
    textWeightController.dispose();
    super.dispose();
  }

  final CheckController checkController = Get.put(CheckController());
  final ControllerDashboardInfo controllerDashboardInfo = Get.find();

  addWeight(String text) {
    var r = double.parse(text);
    assert(r is double);
    controllerDashboardInfo.addWeight(r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32, top: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Введите новые показатели",
                    style: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildCheckBoxAndTextField(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: sizeWaisteTextFieldKey.height,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => IconButton(
                              icon: checkController.getWaisteChecking
                                  ? Icon(
                                      Boxicons.bxs_minus_square,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Boxicons.bxs_plus_square,
                                      color: Colors.green,
                                    ),
                              onPressed: () =>
                                  checkController.changeWaisteChecked(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Obx(
                            () => TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+\.?\d{0,2}"))
                              ],
                              keyboardType: TextInputType.number,
                              key: waisteTextFieldKey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                hintText: 'Объем талии',
                                hintStyle: TextStyle(
                                  fontFamily:
                                      GoogleFonts.robotoSlab().fontFamily,
                                  fontSize: 18,
                                ),
                                enabled: checkController.getWaisteChecking
                                    ? true
                                    : false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO сделать проверку, вдруг ничего не добавили в текстовые поля, а кнопку нажали
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 4,
                      primary: Colors.white,
                      backgroundColor: Colors.redAccent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      addWeight(textWeightController.text);
                      checkController.allCheckesSetFalse();
                      controllerDashboardInfo.update();
                      //valuesController.update();
                      //valuesController.getInfoForWeightAtValuesPage();
                      Navigator.of(context).pop(true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 32.0,
                        right: 32,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Text(
                        "Добавить",
                        style: GoogleFonts.robotoSlab(
                          // fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCheckBoxAndTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: sizeWeightTextFieldKey.height,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(
              () => IconButton(
                icon: checkController.getWeightChecking
                    ? Icon(
                        Boxicons.bxs_minus_square,
                        color: Colors.red,
                      )
                    : Icon(
                        Boxicons.bxs_plus_square,
                        color: Colors.green,
                      ),
                onPressed: () {
                  checkController.changeWeightChecked();
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Obx(
              () => TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                ],
                controller: textWeightController,
                keyboardType: TextInputType.number,
                key: weightTextFieldKey,
                decoration: InputDecoration(
                  // focusColor: Colors.blue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Вес',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.robotoSlab().fontFamily,
                    fontSize: 18,
                  ),
                  enabled: checkController.getWeightChecking ? true : false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
