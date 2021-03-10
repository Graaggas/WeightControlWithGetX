import 'package:get/get.dart';
import 'package:weight_control/services/database.dart';


class ControllerWeight extends GetxController {
  final database = Database();

  var currentWeight = 0.0.obs;
  var startWeight = 0.0.obs;
  var wantedWeight = 0.0.obs;

  void changeCurrentWeight(double value) => currentWeight.value = value;

  void changeStartWeight(double value) => startWeight.value = value;

  void changeWantedWeight(double value) => wantedWeight.value = value;

  Future <void> getInit() async {
    List<double> list = [];
    list = await database.getInit();
    changeWantedWeight(list[0]);
    changeStartWeight(list[1]);
    changeCurrentWeight(list[list.length-1]);
  }

  Future <void> addWeight(double value) async {
    changeCurrentWeight(value);
    await database.addToWeightBox(dateTime: DateTime.now(), valueWeight: value);
  }
}
