import 'package:hive/hive.dart';
import 'package:weight_control/misc/enum.dart';
import 'package:weight_control/misc/logger.dart';
import 'package:weight_control/model/weight/waiste_model.dart';

import 'package:weight_control/model/weight/weight_model.dart';

class Database {
  var weightModel = WeightModel();
  var logger = Logger();
  var waisteModel = WaisteModel();

  Future<Box> openBox(String name) async {
    var box = await Hive.openBox(name);
    return box;
  }

  Future<List<DateTime>> getDatesList(TypeOfData type) async {
    List<DateTime> list = [];
    var box;
    switch (type) {
      case TypeOfData.WAISTE:
        box = await openBox("Waiste");
        WaisteModel waisteModel = box.get(0);

        /// Add map's keys to the list
        for (var item in waisteModel.waiste.entries) {
          list.add(item.key);
        }
        break;
      case TypeOfData.WEIGHT:
        box = await openBox("Weight");
        WeightModel weightModel = box.get(0);

        /// Add map's keys to the list
        for (var item in weightModel.weights.entries) {
          list.add(item.key);
        }

        break;
      default:
        box = await openBox("Weight");
    }

    return list;
  }

  Future<List<double>> getValuesList(TypeOfData type) async {
    List<double> list = [];

    switch (type) {
      case TypeOfData.WEIGHT:
        final box = await openBox("Weight");
        WeightModel model = box.get(0);

        /// Add map's values to the list
        for (var item in model.weights.entries) {
          list.add(item.value);
        }

        break;
      case TypeOfData.WAISTE:
        final box = await openBox("Waiste");
        WaisteModel model = box.get(0);

        /// Add map's values to the list
        for (var item in model.waiste.entries) {
          list.add(item.value);
        }
        break;
      default:
        final box = await openBox("Weight");
        WeightModel model = box.get(0);

        /// Add map's values to the list
        for (var item in model.weights.entries) {
          list.add(item.value);
        }
    }

    return list;
  }

  //collect data from box and represent it via list
  Future<List<double>> initDashboard(TypeOfData type) async {
    var box;
    List<double> list = [];
    if (type == TypeOfData.WEIGHT) {
      box = await openBox("Weight");
    } else {
      box = await openBox("Waiste");
    }



    /// Check box, if it exists and not empty
    if (box.isNotEmpty) {
      print("||Database||initDashboard||\n box is not empty, type = $type\n\n");

      /// testBox(box, "//getInit");
      if (type == TypeOfData.WEIGHT) {
        WeightModel weightModel = box.get(0);

        list.clear();
        /// Add wantedWeight
        print(
            "||Database||initDashboard||\n type = $type,  try to add wantedWeight = ${weightModel.wantedWeight}\n\n");
        list.add(weightModel.wantedWeight);

        /// Add map's entries to the list
        for (var item in weightModel.weights.entries) {
          print(
              "||Database||initDashboard||\n type = $type,  add weights entries to the list = ${item.value}\n\n");
          list.add(item.value);
        }

        return list;
      } else {
        list.clear();
        var model = box.get(0);
        print("!!!!!! model type = ${model.runtimeType}");

        print(
            "||Database||initDashboard||\n type = $type, wantedWaiste = ${model.wantedWaiste}\n\n");

        /// Add wantedWeight
        list.add(model.wantedWaiste);

        /// Add map's entries to the list
        for (var item in model.waiste.entries) {
          print(
              "||Database||initDashboard||\n type = $type,  add waistes entries to the list = ${item.value}\n\n");
          list.add(item.value);
        }

        return list;
      }
    } else {
      print("database. box is empty");
      return null;
    }
    // else {
    //   //dummy data for first
    //   list.add(11);
    //   list.add(12);
    //
    //   addToWeightBox(
    //       dateTime: DateTime.now(),
    //       valueWeight: list[1],
    //       valueWantedWeight: list[0]);
    //   return list;
    // }
  }

  Future<void> changeFlagMeeting() async {
    final box = await openBox("Weight");
    weightModel = box.getAt(0);
    print("Database. flag before changing: ${weightModel.flagFirstMeeting}");
    if (weightModel.flagFirstMeeting == null) {
      weightModel.flagFirstMeeting = true;
    }
    weightModel.changeFlag();
    weightModel.save();
    print("Database. changed flag: ${weightModel.flagFirstMeeting}");
  }

  Future<bool> getFlagFromHive() async {
    final box = await openBox("Weight");
    try {
      weightModel = box.getAt(0);
      var r = weightModel.flagFirstMeeting;
      if (r == null || weightModel == null) {
        print("database. getFlag. flag is not initialized...");

        // print("==> $r");
        return true;
      } else {
        print("database. getFlag. data exists");
        return false;
      }
    } catch (e) {
      print("==> error: $e");
    }
    return null;
  }

  Future<bool> initFlagFirstMeeting(bool flag) async {
    final box = await openBox("Weight");

    weightModel = box.getAt(0);
    weightModel.addFlag(flag);
    weightModel.save();

    print("Database. initFlag. flag : ${weightModel.flagFirstMeeting}");

    return weightModel.flagFirstMeeting;

    // if(box.getAt(1) != null)
    //   {
    //     flag = box.getAt(1);
    //     return flag;
    //   }
    // else{
    //   flag = true;
    //   box.add(flag);
    //   return flag;
    // }
  }

  Future<void> deleteValue(DateTime key, TypeOfData type) async {
    if (type == TypeOfData.WEIGHT) {
      final box = await openBox("Weight");
      weightModel = box.getAt(0);

      weightModel.weights.remove(key);

      //save deleting when weightList is empty
      if (weightModel.weights.length <= 0) {
        weightModel.addWeight(0);
        weightModel.save();
      }

      weightModel.save();
    } else {
      final box = await openBox("Waiste");
      waisteModel = box.getAt(0);

      waisteModel.waiste.remove(key);

      //save deleting when weightList is empty
      if (waisteModel.waiste.length <= 0) {
        waisteModel.addWaiste(0);
        waisteModel.save();
      }

      waisteModel.save();
    }
  }

  Future<int> getValuesLength(TypeOfData type) async {
    if (type == TypeOfData.WEIGHT) {
      final box = await openBox("Weight");
      weightModel = box.getAt(0);
      var length = weightModel.weights.length;
      return length;
    } else {
      final box = await openBox("Waiste");
      waisteModel = box.getAt(0);
      var length = waisteModel.waiste.length;
      return length;
    }
  }

  Future<void> updateOneValue(
      double newValue, DateTime key, TypeOfData type) async {
    if (type == TypeOfData.WEIGHT) {
      final box = await openBox("Weight");
      weightModel = box.getAt(0);
      print("in database. old weight value : ${weightModel.weights[key]}");
      weightModel.weights[key] = newValue;
      weightModel.save();

      weightModel = box.getAt(0);
      print("in database. new weight value : ${weightModel.weights[key]}");
    } else {
      final box = await openBox("Waiste");
      waisteModel = box.getAt(0);
      print("in database. old waiste value : ${waisteModel.waiste[key]}");
      waisteModel.waiste[key] = newValue;
      waisteModel.save();

      waisteModel = box.getAt(01);
      print("in database. new waiste value : ${waisteModel.waiste[key]}");
    }
  }

  Future<void> addStartValueForCalculating(
      double value, TypeOfData type) async {
    if (type == TypeOfData.WEIGHT) {
      final box = await openBox("Weight");
      weightModel = box.getAt(0);
      print(
          "||Database||addStartValueForCalculating||\n type = $type, changing startWeightForCalculating = $value\n\n");
      weightModel.addStartWeightForCalculating(value);
      weightModel.save();
    } else {
      final box = await openBox("Waiste");
      waisteModel = box.getAt(0);
      print(
          "||Database||addStartValueForCalculating||\n type = $type, changing startWeisteForCalculating = $value\n\n");
      waisteModel.addStartWaisteForCalculating(value);
      waisteModel.save();
    }
  }

  Future<void> addWaisteToBox({double value, double valueHeight}) async {
    final box = await openBox("Waiste");

    if (box.isNotEmpty) {
      print("||Database||addWaisteToBox||\n box Waiste is not empty\n\n");
      waisteModel = box.getAt(0);

      if (valueHeight != null) {
        waisteModel.addHeight(valueHeight);
        print(
            "||Database||addWaisteToBox||\n adding height =  $valueHeight\n\n");
      }

      //add weight
      DateTime dateTime = DateTime.now();
      waisteModel.addWaiste(value);
      print("||Database||addWaisteToBox||\n adding waiste =  $value\n\n");

      //save the object in the box
      waisteModel.save();
    } else {
      //if box isn't exist than create it

      print("||database||addWaisteToBox||\nbox Waiste is empty\n");
      var model = WaisteModel();

      print("||database||addWaisteToBox||\nadded height = $valueHeight\n");
      print("||database||addWaisteToBox||\nadded waiste = $value \n");
      model.addHeight(valueHeight);
      model.addWaiste(value);
      model.setWantedWaiste();
      box.add(model);
    }
  }

  Future<void> addWeightToBox({double value, double valueWantedValue}) async {
    final box = await openBox("Weight");

    if (box.isNotEmpty) {
      weightModel = box.getAt(0);
      print("||database||addWeightToBox||\nbox Weight is not empty\n");
      if (valueWantedValue != null) {
        //if wantedWeight is being used, than add it to object
        print(
            "||database||addWeightToBox||\nadded wantedWeight = $valueWantedValue\n");
        weightModel.addWantedWeight(valueWantedValue);
      }

      //add weight
      DateTime dateTime = DateTime.now();
      weightModel.addWeight(value);
      print("||database||addWeightToBox||\nadded weight = $value\n");
      //save the object in the box
      weightModel.save();
    } else {
      //if box isn't exist than create it
      // logger.info("box Weight is empty", 3.0, StackTrace.current);
      print("||database||addWeightToBox||\nbox Weight is empty\n");
      var weightModel = WeightModel();

      print(
          "||database||addWeightToBox||\nadded wantedWeight = $valueWantedValue\n");
      print("||database||addWeightToBox||\nadded weight = $value\n");
      weightModel.addWantedWeight(valueWantedValue);
      weightModel.addWeight(value);
      box.add(weightModel);
    }
  }
}
