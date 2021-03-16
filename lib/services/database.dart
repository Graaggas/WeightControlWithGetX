import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/model/weight/weight_model.dart';


class Database {
  var logger = Logger();
  var weightModel = WeightModel();

  Future<Box> openBox(String name) async {
    var box = await Hive.openBox(name);
    return box;
  }

  Future<List<DateTime>> getDatesList() async {
    List<DateTime> list = [];
    final box = await openBox("Weight");
    WeightModel weightModel = box.get(0);

     /// Add map's keys to the list
    for (var item in weightModel.weights.entries) {
      list.add(item.key);
    }

    return list;
  }

  Future<List<double>> getWeightsList() async {
    List<double> list = [];
    final box = await openBox("Weight");
    WeightModel weightModel = box.get(0);

    /// Add map's values to the list
    for (var item in weightModel.weights.entries) {
      list.add(item.value);
    }

    return list;
  }

  //collect data from box and represent it via list
  Future<List<double>> initDashboard() async {
    final box = await openBox("Weight");
    List<double> list = [];

    /// Check box, if it exists and not empty
    if (box.isNotEmpty) {
      /// testBox(box, "//getInit");
      WeightModel weightModel = box.get(0);

      /// Add wantedWeight
      list.add(weightModel.wantedWeight);

      /// Add map's entries to the list
      for (var item in weightModel.weights.entries) {
        list.add(item.value);
      }

      return list;
    } else {
      //dummy data for first
      list.add(11);
      list.add(12);

      addToWeightBox(
          dateTime: DateTime.now(),
          valueWeight: list[1],
          valueWantedWeight: list[0]);
      return list;
    }
  }

  Future<void> changeFlagMeeting() async {
    final box = await openBox("Weight");
    weightModel = box.getAt(0);
    weightModel.changeFlag();
    weightModel.save();
    print("changed flag: ${weightModel.flagFirstMeeting}");


  }

  Future<bool> initFlagFirstMeeting(bool flag) async {
    final box = await openBox("Weight");

    weightModel = box.getAt(0);
    weightModel.addFlag(flag);
    weightModel.save();

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

  Future <void> deleteWeight(DateTime key) async {
    final box = await openBox("Weight");
    weightModel= box.getAt(0);

   weightModel.weights.remove(key);

    //save deleting when weightList is empty
    if(weightModel.weights.length <= 0){
      weightModel.addWeight(DateTime.now(), 0);
      weightModel.save();
    }


    weightModel.save();
  }

  Future<int> getWeightsLength() async {
    final box = await openBox("Weight");
    weightModel = box.getAt(0);
    var length = weightModel.weights.length;
    return length;
  }

  Future<void> updateOneWeight(double newValue, DateTime key) async {
    final box = await openBox("Weight");
    weightModel = box.getAt(0);
    print("in database. old weight value : ${weightModel.weights[key]}");
    weightModel.weights[key] = newValue;
    weightModel.save();

    weightModel = box.getAt(0);
    print("in database. new weight value : ${weightModel.weights[key]}");

  }

  Future<void> addToWeightBox(
      {DateTime dateTime, double valueWeight, double valueWantedWeight}) async {
    final box = await openBox("Weight");

    if (box.isNotEmpty) {
      weightModel = box.getAt(0);

      if (valueWantedWeight != null) {
        //if wantedWeight is being used, than add it to object
        weightModel.addWantedWeight(valueWantedWeight);
      }

      //add weight
      weightModel.addWeight(dateTime, valueWeight);
      //save the object in the box
      weightModel.save();


      //TEST
      weightModel = box.getAt(0);
      var r = await getWeightsList();
      print("******************************");
      print("database. after saving weightsList : $r");
      print("database. after saving itemCounter : ${r.length}");
      print("******************************");

    } else {
      //if box isn't exist than create it
      var weightModel = WeightModel();

      weightModel.addWantedWeight(valueWantedWeight);
      weightModel.addWeight(dateTime, valueWeight);
      box.add(weightModel);
    }
  }


}
