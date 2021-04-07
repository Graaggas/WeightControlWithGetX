import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_control/misc/validators.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_control/misc/converters.dart';
import 'package:weight_control/screens/first-meeting/first-meeting-controller.dart';
import 'package:weight_control/screens/home-page/home_page.dart';

class FirstMeeting extends StatefulWidget {
  @override
  _FirstMeetingState createState() => _FirstMeetingState();
}

class _FirstMeetingState extends State<FirstMeeting> {
  final textStartWeightController = TextEditingController();

  final textWantedWeightController = TextEditingController();

  final textWaisteController = TextEditingController();

  final textHeightController = TextEditingController();

  final DoubleValidator startWeightValidator = NonEmptyDoubleValidator();

  bool isChecked;

  @override
  void dispose() {
    textStartWeightController.dispose();
    textWantedWeightController.dispose();
    textHeightController.dispose();
    textWaisteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isChecked = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ControllerDashboardInfo controllerDashboardInfo = Get.find();
    final FirstMeetingController firstMeetingController = Get.find();

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Введите начальные значения",
                    style: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите значение";
                        }
                        return null;
                      },
                      controller: textStartWeightController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.number,
                      // key: waisteTextFieldKey,
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Текущий вес (кг)',
                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите значение";
                        }
                        return null;
                      },
                      controller: textWantedWeightController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.number,
                      // key: waisteTextFieldKey,
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Желаемый вес (кг)',
                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GFCheckbox(
                          size: GFSize.SMALL,
                          activeBgColor: GFColors.SECONDARY,
                          type: GFCheckboxType.square,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                          value: isChecked,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Учет окружности талии",
                            style: GoogleFonts.robotoSlab(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (isChecked) {
                          if (value == null || value.isEmpty) {
                            return "Введите значение";
                          }
                          return null;
                        } else
                          return null;
                      },
                      enabled: isChecked,
                      controller: textWaisteController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.number,
                      // key: waisteTextFieldKey,
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Окружность талии (см)',
                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (isChecked) {
                          if (value == null || value.isEmpty) {
                            return "Введите значение";
                          }
                          return null;
                        } else
                          return null;
                      },
                      enabled: isChecked,
                      controller: textHeightController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.number,
                      // key: waisteTextFieldKey,
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Рост (см)',
                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  // OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     elevation: 4,
                  //     primary: Colors.white,
                  //     backgroundColor: Colors.redAccent,
                  //     shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   ),
                  //   onPressed: () async {
                  //     await firstMeetingController.putInitWeight(
                  //         startWeight1: convertDoubleToString(
                  //             textStartWeightController.text),
                  //         wantedWeight1:
                  //             convertDoubleToString(textWantedController.text));
                  //     await firstMeetingController.changeFlagFirstMeeting();
                  //     Get.off(() => HomePage());
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       left: 32.0,
                  //       right: 32,
                  //       top: 8,
                  //       bottom: 8,
                  //     ),
                  //     child: Text(
                  //       "Добавить",
                  //       style: TextStyle(fontSize: 22),
                  //     ),
                  //   ),
                  // ),
                  GFButton(
                    elevation: 4,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await firstMeetingController.putInitWeight(
                            startWeight1: convertStringToDouble(
                                textStartWeightController.text),
                            wantedWeight1: convertStringToDouble(
                                textWantedWeightController.text));
                        await firstMeetingController.changeFlagFirstMeeting();
                        await firstMeetingController.putInitWaiste(
                          startWaiste1:
                              convertStringToDouble(textWaisteController.text),
                          height:
                              convertStringToDouble(textHeightController.text),
                        );
                        Get.off(() => HomePage());
                      }
                    },
                    text: "Добавить",
                    textStyle: GoogleFonts.robotoSlab(
                      // fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                    size: GFSize.LARGE,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
