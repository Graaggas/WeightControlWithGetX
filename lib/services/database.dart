import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/model/weight/weight_model.dart';

class Database {
  var logger = Logger();

  Future<Box> openBox(String name) async {
    var box = await Hive.openBox(name);
    return box;
  }

  Future<double> getCurrentWeight() async {
    var box = await openBox("Weight");
    var weightModel = WeightModel();
    weightModel = box.get(0);
    double res = 0;
    res = weightModel.lastCurrentWeight();
    return res;
  }

  Future<void> createBoxWeight(
      DateTime dateTime, double valueCurrentWeight, double wantedWeight) async {
    var weightModel = WeightModel();
    var box = await openBox("Weight");
    weightModel.addWantedWeight(wantedWeight);
    weightModel.addWeight(dateTime, valueCurrentWeight);

    box.add(weightModel);
  }

  Future<void> addToWeightBox({DateTime dateTime, double valueWeight,
      double valueWantedWeight}) async {
    final box = await openBox("Weight");
    var weightModel = WeightModel();

    if (box.isNotEmpty) {
      weightModel = box.getAt(0);

      if (valueWantedWeight != null) {
        weightModel.addWantedWeight(valueWantedWeight);
      }

      weightModel.addWeight(dateTime, valueWeight);
      weightModel.save();
    } else {
      createBoxWeight(dateTime, valueWeight, valueWantedWeight);
    }
  }

  Future<List<double>> getInit() async {
    final box = await openBox("Weight");
    List<double> list = [];

    /// Check box, if it exists and not empty
    if (box.isNotEmpty) {

     /// testBox(box, "//getInit");

      WeightModel weightModel = box.get(0);

      /// Add wantedWeight
      list.add(weightModel.wantedWeight);
      logger.i("getInit(). from box => wantedWeight = ${weightModel.wantedWeight}");


      /// Add map's entries to the list
      for (var item in weightModel.weights.entries) {
        list.add(item.value);

        logger.i("getInit(). from box => weight: ${item.value}");
      }
      return list;
    } else {
      list.add(11);
      list.add(12);
      addToWeightBox(dateTime: DateTime.now(), valueWeight: list[1], valueWantedWeight: list[0]);
      return list;
    }
  }
}
