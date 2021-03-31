import 'package:get/get.dart';
import 'package:weight_control/misc/logger.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weight_control/services/database.dart';

class ControllerDashboardInfo extends GetxController {
  final database = Database();
  var logger = Logger();

  var averageWeightAllDays = 0.0.obs;
  var averageWeightSevenDays = 0.0.obs;
  var averageWeightFourteenDays = 0.0.obs;
  var averageWeightMonth = 0.0.obs;

  var stopInit = false.obs;

  var currentIsFirstInList = true.obs;

  // var flagFirstWeightInList = true.obs;

  var flagFirstMeeting = true.obs;

  var itemCounter = 0.obs;

  var currentWeight = 0.0.obs;
  var startWeight = 0.0.obs;
  var wantedWeight = 0.0.obs;
  var weightsList = [].obs;
  var datesList = [].obs;

  var previousWeight = 0.0.obs;

  var angleWeight = 0.0.obs;
  var diff = 0.0;
  var anglePerKg = 0.0;
  var startWeightForCalculating = 0.0;

  Future<void> getMonthsAverage() async {
    double averageMonth = 0.0;
    double diff = 0.0;

    var cuDay = datesList[datesList.length - 1];
    var currentDay = Jiffy(cuDay);
    logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
        StackTrace.current);
    var now = Jiffy(DateTime.now());
    var firstOfMonth = now.subtract(days: 31);
    List<double> list = [];
    for (int i = 0; i < datesList.length; i++) {
      var r = Jiffy(datesList[i]);

      print(r.format("dd MMMM yyyy, hh:mm:ss"));
      if (r.isBetween(firstOfMonth, currentDay.add(days: 1))) {
        print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(weightsList[i]);
      }

      // print("==> 14 => ${averageWeightFourteenDays.value}");
    }

    print("aver start = $averageMonth");
    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      print("${list[i]}-${list[i - 1]}");
      averageMonth = averageMonth + diff;
      print("aver = $averageMonth");
    }

    logger.info("14 days diff", averageMonth, StackTrace.current);
    averageWeightMonth.value = averageMonth;
  }

  Future<void> getFourteenDaysAverage() async {
    double average7days = 0.0;
    double diff = 0.0;
    print("~~aver start = $average7days");

    var cuDay = datesList[datesList.length - 1];
    var currentDay = Jiffy(cuDay);
    logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
        StackTrace.current);
    var now = Jiffy(DateTime.now());
    var firstOfFourteenDay = now.subtract(days: 14);
    List<double> list = [];
    for (int i = 0; i < datesList.length; i++) {
      var r = Jiffy(datesList[i]);

      print(r.format("dd MMMM yyyy, hh:mm:ss"));
      if (r.isBetween(firstOfFourteenDay, currentDay.add(days: 1))) {
        print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(weightsList[i]);
      }

      // print("==> 14 => ${averageWeightFourteenDays.value}");
    }
    print("Получили такой лист с 14 днями: ${list.toString()}");

    print("aver start = $average7days");
    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      print("${list[i]}-${list[i - 1]}");
      average7days = average7days + diff;
      print("aver = $average7days");
    }

    logger.info("14 days diff", average7days, StackTrace.current);
    averageWeightFourteenDays.value = average7days;
  }

  Future<void> getSevenDaysAverage() async {
    double average = 0.0;
    double diff = 0.0;

    var cuDay = datesList[datesList.length - 1];

    var currentDay = Jiffy(cuDay);
    logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
        StackTrace.current);

    var now = Jiffy(DateTime.now());

    var firstOfSevenDay = now.subtract(days: 7);
    logger.info("first of seven day",
        firstOfSevenDay.format("dd MMMM yyyy, hh:mm:ss"), StackTrace.current);

    // datesList.forEach((element) {
    //   var r = Jiffy(element);
    //   print(r.format("dd MMMM yyyy, hh:mm:ss"));
    //   if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
    //     print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
    //   }
    // });

    List<double> list = [];
    for (int i = 0; i < datesList.length; i++) {
      var r = Jiffy(datesList[i]);

      print(r.format("dd MMMM yyyy, hh:mm:ss"));
      if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
        print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(weightsList[i]);
      }
    }

    print("Получили такой лист с 7 днями: ${list.toString()}");

    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      average = average + diff;
    }

    logger.info("7 days diff", average, StackTrace.current);
    averageWeightSevenDays.value = average;
  }

  Future<void> getWeightAllDaysValue() async {
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
    print(
        "getWeightAllDaysValue//\tAverage Weight for all days: ${averageWeightAllDays.value}");
  }

  double getDiffCurrentPrevoius() {
    double diff = 0.0;
    if (previousWeight.value > 0) {
      diff = currentWeight.value - previousWeight.value;
    } else {
      diff = 0;
    }

    // print("getDiffCurrentPrevious//\tdiff of weights = $diff");
    logger.info("diff", diff, StackTrace.current);
    return diff;
  }

  Future<void> getPreviousWeight() async {
    //найти предыдущий вес, если знаем текущий

    var indexOfCurrentWeight = weightsList.indexOf(currentWeight.value);
    print("getPreviousWeight//\tcurrentWeight = ${currentWeight.value}");
    print(
        "getPreviousWeight//\tindex of currentWeight is $indexOfCurrentWeight");

    if (indexOfCurrentWeight <= 0) {
      print("getPreviousWeight//\tindex is less or equals 0");
      currentIsFirstInList.value = true;
    } else {
      currentIsFirstInList.value = false;
      previousWeight.value = weightsList[indexOfCurrentWeight - 1];
      print("getPreviousWeight//\tpreviousWeight = ${previousWeight.value}");
    }
  }

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

      await getPreviousWeight();
      await updateAngleWeight();
      await getWeightAllDaysValue();
      await getSevenDaysAverage();
      await getFourteenDaysAverage();
      await getMonthsAverage();
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
    print(
        "updateAngleWeight//\tstartWeightForCalculating = $startWeightForCalculating");
    diff = startWeightForCalculating - currentWeight.value;

    print("updateAngleWeight//\tdiff = $diff");
    print("updateAngleWeight//\tanglePerKg = $anglePerKg");

    angleWeight.value = diff.abs() * anglePerKg;

    print("updateAngleWeight//\tangleWeight = ${angleWeight.value}");

    update();
  }

  void addWeight(double value) async {
    print("addWeight//\t adding new weight...");
    print("addWeight//\t current itemCounter : ${itemCounter.value}");

    await database.addToWeightBox(valueWeight: value);

    if (value > startWeight.value) {
      await database.addStartWeightForCalculating(value);
      startWeightForCalculating = value;
      updateAngleWeight();
    }

    await getWeightAllDaysValue();
    await updateWeightData();

    update();
  }

  Future<void> updateWeightData() async {
    await updateDates();
    await updateWeights();
    await updateCurrentWeight();
    await updateItemCounter();
    await updateAngleWeight();
    await getPreviousWeight();
    await getWeightAllDaysValue();
    await getSevenDaysAverage();
    await getFourteenDaysAverage();
    await getMonthsAverage();

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

    print("updateOneWeight//\t $weightsList");
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
      print("updateCurrentWeight//\tlength of weightlist is less or equals 0");
    } else {
      currentWeight.value = r[length - 1];
    }
  }
}
