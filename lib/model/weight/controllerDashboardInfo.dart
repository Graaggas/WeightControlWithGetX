import 'package:get/get.dart';

import 'package:weight_control/services/database.dart';

class ControllerDashboardInfo extends GetxController {
  final database = Database();

  var stopInit = false.obs;

  var flagFirstMeeting = true.obs;

  var itemCounter = 0.obs;

  var currentWeight = 0.0.obs;
  var startWeight = 0.0.obs;
  var wantedWeight = 0.0.obs;
  var weightsList = [].obs;
  var datesList = [].obs;

  var angleWeight = 0.0.obs;

  var diff = 0.0;
  var anglePerKg = 0.0;
  var startWeightForCalculating = 0.0;

  void init() async {
    if (stopInit.value == false) {
      print("Dashboard controller's init...");

      List<double> firstDataList = await database.initDashboard();
      if (firstDataList != null) {
        currentWeight.value = firstDataList[firstDataList.length - 1];
        wantedWeight.value = firstDataList[0];
        startWeight.value = firstDataList[1];
        startWeightForCalculating = startWeight.value;
        print(
            "init controller. startWeightForCalculating : $startWeightForCalculating");

        firstDataList.forEach((element) {
          if (element > startWeight.value) {
            startWeightForCalculating = element;
          }
        });

        List<double> weights = await database.getWeightsList();
        weightsList.addAll(weights);

        List<DateTime> dates = await database.getDatesList();
        datesList.addAll(dates);

        itemCounter.value = weightsList.length;
      } else {
        initFlagFirstMeeting();
        print("controller. first start...");
      }

      updateAngleWeight();
      update();

      //TEST
      print("******************************");
      print("onInit... List of weights:");
      weightsList.forEach((element) {
        print(element);
      });
      print("******************************");

      stopInit.value = true;
    }
  }

  void initFlagFirstMeeting() async {
    bool flag = await database.getFlagFromHive();
    bool r = await database.initFlagFirstMeeting(flag);
    flagFirstMeeting.value = r;
    print("==> in controller init ==> flag = $flagFirstMeeting");
  }

  Future<void> updateAngleWeight() async {
    if (currentWeight.value <= startWeight.value) {
      anglePerKg = 360 / (startWeightForCalculating - wantedWeight.value);
    } else {
      anglePerKg = 360 / (currentWeight.value - wantedWeight.value);
    }
    print("startWeightForCalculating = $startWeightForCalculating");
    diff = startWeightForCalculating - currentWeight.value;

    print("diff = $diff");
    print("anglePerKg = $anglePerKg");

    angleWeight.value = diff.abs() * anglePerKg;

    print("angleWeight = ${angleWeight.value}");

    update();
  }

  void addWeight(double value) async {
    print("in controller adding new weight...");
    print("in controller current itemCounter : ${itemCounter.value}");

    await database.addToWeightBox(valueWeight: value);

    if (value > startWeight.value) {
      await database.addStartWeightForCalculating(value);
      startWeightForCalculating = value;
      updateAngleWeight();
    }

    await updateWeightData();
    update();
  }

  Future<void> updateWeightData() async {
    await updateDates();
    await updateWeights();
    await updateCurrentWeight();
    await updateItemCounter();
    await updateAngleWeight();

    update();
  }

  Future<void> updateItemCounter() async {
    var r = await database.getWeightsLength();
    itemCounter.value = r;

    // if(weightsList.length <= 0) {
    //   itemCounter.value = 0;
    // }
    // else{
    //   itemCounter.value = weightsList.length;
    // }

    update();
  }

  Future<void> deleteWeight(DateTime key) async {
    await database.deleteWeight(key);
    await updateWeightData();
    update();
  }

  Future<void> updateOneWeight(double newValue, DateTime key) async {
    await database.updateOneWeight(newValue, key);
    await updateWeightData();
    update();

    print("===> $weightsList");
  }

  Future<void> updateWeights() async {
    List<double> r = await database.getWeightsList();
    // weightsList.clear();
    weightsList.assignAll(r);
    //weightsList.addAll(r);
    update();
  }

  Future<void> updateDates() async {
    List<DateTime> r = await database.getDatesList();
    //datesList.clear();
    //datesList.addAll(r);
    datesList.assignAll(r);
    update();
  }

  Future<void> updateCurrentWeight() async {
    List<double> r = await database.getWeightsList();
    int length = r.length;

    if (r.length <= 0) {
      currentWeight.value = 0;
    } else {
      currentWeight.value = r[length - 1];
    }
  }
}
