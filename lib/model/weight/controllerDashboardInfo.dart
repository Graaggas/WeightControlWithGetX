import 'package:get/get.dart';
import 'package:weight_control/misc/chart_data.dart';
import 'package:weight_control/misc/converters.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weight_control/misc/enum.dart';
import 'package:weight_control/services/database.dart';

class ControllerDashboardInfo extends GetxController {
  final database = Database();

  var chartWeights = <ChartValues>[].obs;
  var chartWaiste = <ChartValues>[].obs;

  var averageWeightAllDays = 0.0.obs;
  var averageWeightSevenDays = 0.0.obs;
  var averageWeightFourteenDays = 0.0.obs;
  var averageWeightMonth = 0.0.obs;

  var averageWaisteAllDays = 0.0.obs;
  var averageWaisteSevenDays = 0.0.obs;
  var averageWaisteFourteenDays = 0.0.obs;
  var averageWaisteMonth = 0.0.obs;

  var stopInit = false.obs;

  var currentIsFirstInListWeight = true.obs;
  var currentIsFirstInListWaiste = true.obs;

  // var flagFirstWeightInList = true.obs;

  var flagFirstMeeting = true.obs;

  var itemCounter = 0.obs;

  var itemCounterWaiste = 0.obs;

  var currentWeight = 0.0.obs;
  var startWeight = 0.0.obs;
  var wantedWeight = 0.0.obs;
  var weightsList = [].obs;
  var datesOfWeightsList = [].obs;

  var currentWaiste = 0.0.obs;
  var startWaiste = 0.0.obs;
  var wantedWaiste = 0.0.obs;
  var waisteList = [].obs;
  var datesOfWaisteList = [].obs;

  var previousWeight = 0.0.obs;
  var previousWaiste = 0.0.obs;

  var angleWaiste = 0.0.obs;
  var diffAngleWaiste = 0.0;
  var anglePerCm = 0.0;
  var startWaisteForCalculating = 0.0;

  var angleWeight = 0.0.obs;
  var diffAngleWeight = 0.0;
  var anglePerKg = 0.0;
  var anglePerCM = 0.0;
  var startWeightForCalculating = 0.0;

  Future<List<ChartValues>> getChartWaiste() async {
    List<double> waiste = [];
    List<String> dates = [];
    List<ChartValues> list = [];

    waisteList.forEach((element) {
      waiste.add(element);
    });

    datesOfWaisteList.forEach((element) {
      dates.add(convertFromDateTimeToString(element));
    });

    for (int i = 0; i < waisteList.length; i++) {
      var chart = ChartValues(dates[i], waiste[i]);

      print(
          "||controllerDashboard||getChartWaiste||\n date: ${chart.date}, value: ${chart.value}\n\n");

      list.add(chart);
    }

    return list;
  }

  Future<List<ChartValues>> getChartWeights() async {
    List<double> weights = [];
    List<String> dates = [];
    List<ChartValues> list = [];

    weightsList.forEach((element) {
      weights.add(element);
    });

    datesOfWeightsList.forEach((element) {
      dates.add(convertFromDateTimeToString(element));
    });

    for (int i = 0; i < weightsList.length; i++) {
      var chart = ChartValues(dates[i], weights[i]);

      print(
          "||controllerDashboard||getChartWeights||\n date: ${chart.date}, value: ${chart.value}\n\n");

      list.add(chart);
    }

    return list;
  }

  Future<void> updateChartObs() async {
    chartWaiste.clear();
    chartWeights.clear();
    var r = await getChartWeights();
    r.forEach((element) {
      chartWeights.add(element);
    });

    var s = await getChartWaiste();
    s.forEach((element) {
      chartWaiste.add(element);
    });

    //
  }

  Future<void> getMonthsAverage() async {
    double averageMonth = 0.0;
    double diff = 0.0;

    var cuDay = datesOfWeightsList[datesOfWeightsList.length - 1];
    var currentDay = Jiffy(cuDay);
    // logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
    //     StackTrace.current);
    var now = Jiffy(DateTime.now());
    var firstOfMonth = now.subtract(days: 31);
    List<double> list = [];
    for (int i = 0; i < datesOfWeightsList.length; i++) {
      var r = Jiffy(datesOfWeightsList[i]);

      // print(r.format("dd MMMM yyyy, hh:mm:ss"));
      if (r.isBetween(firstOfMonth, currentDay.add(days: 1))) {
        // print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(weightsList[i]);
      }

      // print("==> 14 => ${averageWeightFourteenDays.value}");
    }

    // print("aver start = $averageMonth");
    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      print("${list[i]}-${list[i - 1]}");
      averageMonth = averageMonth + diff;
      print("aver = $averageMonth");
    }
    //
    // logger.info("14 days diff", averageMonth, StackTrace.current);
    averageWeightMonth.value = averageMonth;

    try {
      averageMonth = 0.0;
      diff = 0.0;
      cuDay = datesOfWaisteList[datesOfWaisteList.length - 1];
      currentDay = Jiffy(cuDay);
      // logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
      //     StackTrace.current);
      now = Jiffy(DateTime.now());
      firstOfMonth = now.subtract(days: 31);
      list = [];
      for (int i = 0; i < datesOfWaisteList.length; i++) {
        var r = Jiffy(datesOfWaisteList[i]);

        if (r.isBetween(firstOfMonth, currentDay.add(days: 1))) {
          list.add(waisteList[i]);
        }
      }
      for (int i = 1; i < list.length; i++) {
        diff = list[i] - list[i - 1];
        print("${list[i]}-${list[i - 1]}");
        averageMonth = averageMonth + diff;
        print("aver = $averageMonth");
      }

      averageWaisteMonth.value = averageMonth;
    } catch (e) {}
  }

  Future<void> getFourteenDaysAverage() async {
    double average7days = 0.0;
    double diff = 0.0;

    var cuDay = datesOfWeightsList[datesOfWeightsList.length - 1];
    var currentDay = Jiffy(cuDay);

    var now = Jiffy(DateTime.now());
    var firstOfFourteenDay = now.subtract(days: 14);
    List<double> list = [];
    for (int i = 0; i < datesOfWeightsList.length; i++) {
      var r = Jiffy(datesOfWeightsList[i]);

      if (r.isBetween(firstOfFourteenDay, currentDay.add(days: 1))) {
        print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(weightsList[i]);
      }
    }

    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      print("${list[i]}-${list[i - 1]}");
      average7days = average7days + diff;
      print("aver = $average7days");
    }

    averageWeightFourteenDays.value = average7days;

    try {
      cuDay = datesOfWaisteList[datesOfWaisteList.length - 1];
      currentDay = Jiffy(cuDay);

      now = Jiffy(DateTime.now());
      firstOfFourteenDay = now.subtract(days: 14);
      list = [];
      for (int i = 0; i < datesOfWaisteList.length; i++) {
        var r = Jiffy(datesOfWaisteList[i]);

        if (r.isBetween(firstOfFourteenDay, currentDay.add(days: 1))) {
          print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
          list.add(waisteList[i]);
        }
      }
      diff = 0.0;
      for (int i = 1; i < list.length; i++) {
        diff = list[i] - list[i - 1];
        print("${list[i]}-${list[i - 1]}");
        average7days = average7days + diff;
        print("aver = $average7days");
      }
      averageWaisteFourteenDays.value = average7days;
    } catch (e) {}
  }

  Future<void> getSevenDaysAverage() async {
    double average = 0.0;
    double diff = 0.0;

    var cuDay = datesOfWeightsList[datesOfWeightsList.length - 1];

    var currentDay = Jiffy(cuDay);

    var now = Jiffy(DateTime.now());

    var firstOfSevenDay = now.subtract(days: 7);

    List<double> list = [];
    for (int i = 0; i < datesOfWeightsList.length; i++) {
      var r = Jiffy(datesOfWeightsList[i]);

      if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
        list.add(weightsList[i]);
      }
    }

    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      print("||controllerDashboard||getSevenDaysAverage||\n diff: $diff\n\n");
      average = average + diff;
      print(
          "||controllerDashboard||getSevenDaysAverage||\n average: $average\n\n");
    }

    averageWeightSevenDays.value = average;
    print(
        "||controllerDashboard||getSevenDaysAverage||\n averageWeightSevenDays: ${averageWeightSevenDays.value}\n\n");

    try {
      cuDay = datesOfWaisteList[datesOfWaisteList.length - 1];
      currentDay = Jiffy(cuDay);

      now = Jiffy(DateTime.now());

      firstOfSevenDay = now.subtract(days: 7);

      list = [];
      for (int i = 0; i < datesOfWaisteList.length; i++) {
        var r = Jiffy(datesOfWaisteList[i]);

        if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
          // print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
          list.add(waisteList[i]);
        }
      }

      for (int i = 1; i < list.length; i++) {
        diff = list[i] - list[i - 1];
        print("||controllerDashboard||getSevenDaysAverage||\n diff: $diff\n\n");
        average = average + diff;
        print(
            "||controllerDashboard||getSevenDaysAverage||\n average: $average\n\n");
      }

      // logger.info("7 days diff", average, StackTrace.current);
      averageWaisteSevenDays.value = average;
    } catch (e) {}
  }

  Future<void> getAllDaysValue() async {
    double average = 0.0;
    double diff = 0.0;

    for (int i = 0; i < weightsList.length; i++) {
      if (i == 0) {
      } else {
        diff = weightsList[i] - weightsList[i - 1];
        average = average + diff;
      }
    }

    averageWeightAllDays.value = average;

    average = 0.0;
    diff = 0.0;

    for (int i = 0; i < waisteList.length; i++) {
      if (i == 0) {
      } else {
        diff = waisteList[i] - waisteList[i - 1];
        average = average + diff;
      }
    }

    averageWaisteAllDays.value = average;
    // print(
    //     "getWeightAllDaysValue//\tAverage Weight for all days: ${averageWeightAllDays.value}");
  }

  double getDiffCurrentPrevoius() {
    double diff = 0.0;
    if (previousWeight.value > 0) {
      diff = currentWeight.value - previousWeight.value;
    } else {
      diff = 0;
    }

    // print("getDiffCurrentPrevious//\tdiff of weights = $diff");

    return diff;
  }

  Future<void> getPreviousValue() async {
    //найти предыдущий вес, если знаем текущий

    var indexOfCurrentWeight = weightsList.indexOf(currentWeight.value);
    // print("getPreviousWeight//\tcurrentWeight = ${currentWeight.value}");
    // print(
    // "getPreviousWeight//\tindex of currentWeight is $indexOfCurrentWeight");

    if (indexOfCurrentWeight <= 0) {
      // print("getPreviousWeight//\tindex is less or equals 0");
      currentIsFirstInListWeight.value = true;
    } else {
      currentIsFirstInListWeight.value = false;
      previousWeight.value = weightsList[indexOfCurrentWeight - 1];
      // print("getPreviousWeight//\tpreviousWeight = ${previousWeight.value}");

    }

    var indexOfCurrentWaiste = waisteList.indexOf(currentWaiste.value);

    if (indexOfCurrentWaiste <= 0) {
      currentIsFirstInListWaiste.value = true;
    } else {
      currentIsFirstInListWaiste.value = false;
      previousWaiste.value = waisteList[indexOfCurrentWaiste - 1];
    }
  }

  void init() async {
    if (stopInit.value == false) {
      print("Dashboard controller's init... stopInit = false");

      List<double> firstDataList =
          await database.initDashboard(TypeOfData.WEIGHT);
      if (firstDataList != null) {
        currentWeight.value = firstDataList[firstDataList.length - 1];
        print(
            "||controllerDashboard||init||\n currentWeight: ${currentWeight.value}\n\n");
        wantedWeight.value = firstDataList[0];
        print(
            "||controllerDashboard||init||\n wantedWeight: ${wantedWeight.value}\n\n");
        startWeight.value = firstDataList[1];
        print(
            "||controllerDashboard||init||\n startWeight: ${startWeight.value}\n\n");
        startWeightForCalculating = startWeight.value;
        print(
            "||controllerDashboard||init||\n startWeightForCalculating: $startWeightForCalculating\n\n");

        firstDataList.forEach((element) {
          if (element > startWeight.value) {
            startWeightForCalculating = element;
            print(
                "||controllerDashboard||init||\n new startWeightForCalculating: $startWeightForCalculating\n\n");
          }
        });

        List<double> weights = await database.getValuesList(TypeOfData.WEIGHT);
        weightsList.clear();
        weightsList.addAll(weights);

        List<DateTime> dates = await database.getDatesList(TypeOfData.WEIGHT);
        datesOfWeightsList.clear();
        datesOfWeightsList.addAll(dates);

        itemCounter.value = weightsList.length;
      }

      ///************************************
      firstDataList.clear();
      firstDataList = await database.initDashboard(TypeOfData.WAISTE);
      if (firstDataList != null) {
        currentWaiste.value = firstDataList[firstDataList.length - 1];
        print(
            "||controllerDashboard||init||\n currentWaiste: ${currentWaiste.value}\n\n");

        wantedWaiste.value = firstDataList[0];
        print(
            "||controllerDashboard||init||\n wantedWaiste: ${wantedWaiste.value}\n\n");

        startWaiste.value = firstDataList[1];
        print(
            "||controllerDashboard||init||\n startWaiste: ${startWaiste.value}\n\n");

        startWaisteForCalculating = startWaiste.value;
        print(
            "||controllerDashboard||init||\n startWaisteForCalculating: $startWeightForCalculating\n\n");

        firstDataList.forEach((element) {
          if (element > startWaiste.value) {
            startWaisteForCalculating = element;
            print(
                "||controllerDashboard||init||\n new startWaisteForCalculating: $startWeightForCalculating\n\n");
          }
        });

        List<double> waistes = await database.getValuesList(TypeOfData.WAISTE);
        waisteList.clear();
        waisteList.addAll(waistes);

        List<DateTime> dates = await database.getDatesList(TypeOfData.WAISTE);
        datesOfWaisteList.clear();
        datesOfWaisteList.addAll(dates);

        itemCounterWaiste.value = waisteList.length;

        print("list of weights");
        print(weightsList);
        print("list of waistes");
        print(waisteList);
      }
    } else {
      initFlagFirstMeeting();
      print("controller. first start...");
    }

    // await getPreviousValue();
    // await updateAngle();
    // await getAllDaysValue();
    // await getSevenDaysAverage();
    // await getFourteenDaysAverage();
    // await getMonthsAverage();
    // await updateChartObs();
    await updateWeightData();
    update();

    stopInit.value = true;
  }

  void initFlagFirstMeeting() async {
    bool flag = await database.getFlagFromHive();
    bool r = await database.initFlagFirstMeeting(flag);
    flagFirstMeeting.value = r;
    print("==> in controller init ==> flag = $flagFirstMeeting");
  }

  Future<void> updateAngle() async {
    if (currentWeight.value <= startWeight.value) {
      anglePerKg = 360 / (startWeightForCalculating - wantedWeight.value);
    } else {
      anglePerKg = 360 / (currentWeight.value - wantedWeight.value);
    }
    diffAngleWeight = startWeightForCalculating - currentWeight.value;

    angleWeight.value = diffAngleWeight.abs() * anglePerKg;

    if (currentWaiste.value <= startWaiste.value) {
      anglePerCM = 360 / (startWaisteForCalculating - wantedWaiste.value);
    } else {
      anglePerCM = 360 / (currentWaiste.value - wantedWaiste.value);
    }
    diffAngleWaiste = startWaisteForCalculating - currentWaiste.value;
    angleWaiste.value = diffAngleWaiste.abs() * anglePerCM;

    update();
  }

  void addWeight(double value) async {
    print("||controllerDashboard||addWeight\n try to add weight: $value\n\n");

    await database.addWeightToBox(value: value);

    if (value > startWeight.value) {
      await database.addStartValueForCalculating(value, TypeOfData.WEIGHT);
      startWeightForCalculating = value;
      updateAngle();
    }

    await getAllDaysValue();
    await updateWeightData();

    update();
    print(
        "||controllerDashboard||addWeight||\n weights list: $weightsList\n\n");
  }

  Future<void> updateWeightData() async {
    await updateAllDates(); //+
    await updateWeightsAndWaiste(); //+
    await updateCurrentWeightAndWaiste(); //+
    await updateItemCounter(); //+
    await updateAngle(); //+
    await getPreviousValue(); //+
    await getAllDaysValue(); //+
    await getSevenDaysAverage(); //+
    await getFourteenDaysAverage(); //+
    await getMonthsAverage(); //+
    await updateChartObs(); //+

    update();
  }

  Future<void> updateItemCounter() async {
    var r = await database.getValuesLength(TypeOfData.WEIGHT);
    itemCounter.value = r;

    var s = await database.getValuesLength(TypeOfData.WAISTE);
    itemCounterWaiste.value = s;

    // if(weightsList.length <= 0) {
    //   itemCounter.value = 0;
    // }
    // else{
    //   itemCounter.value = weightsList.length;
    // }

    update();
  }

  Future<void> deleteWeight(DateTime key) async {
    await database.deleteValue(key, TypeOfData.WEIGHT);
    await updateWeightData();

    update();
  }

  Future<void> deleteWaiste(DateTime key) async {
    await database.deleteValue(key, TypeOfData.WAISTE);
    await updateWeightData();

    update();
  }

  Future<void> updateOneWeight(double newValue, DateTime key) async {
    await database.updateOneValue(newValue, key, TypeOfData.WEIGHT);
    await updateWeightData();

    update();

    print("updateOneWeight//\t $weightsList");
  }

  Future<void> updateWeightsAndWaiste() async {
    List<double> r = await database.getValuesList(TypeOfData.WEIGHT);
    List<double> s = await database.getValuesList(TypeOfData.WAISTE);
    weightsList.clear();
    waisteList.clear();
    weightsList.assignAll(r);
    waisteList.assignAll(s);
    //weightsList.addAll(r);
    update();
  }

  Future<void> updateAllDates() async {
    List<DateTime> r = await database.getDatesList(TypeOfData.WEIGHT);
    List<DateTime> s = await database.getDatesList(TypeOfData.WAISTE);
    //datesList.clear();
    //datesList.addAll(r);
    datesOfWeightsList.assignAll(r);
    datesOfWaisteList.assignAll(s);
    update();
  }

  Future<void> updateCurrentWeightAndWaiste() async {
    List<double> r = await database.getValuesList(TypeOfData.WEIGHT);
    List<double> s = await database.getValuesList(TypeOfData.WAISTE);
    int length = 0;
    length = r.length;

    if (r.length <= 0) {
      currentWeight.value = 0;
      print("updateCurrentWeight//\tlength of weightlist is less or equals 0");
    } else {
      currentWeight.value = r[length - 1];
    }

    length = s.length;
    if (s.length <= 0) {
      currentWaiste.value = 0;
      print("updateCurrentWaiste//\tlength of waistelist is less or equals 0");
    } else {
      currentWaiste.value = s[length - 1];
    }
  }
}
