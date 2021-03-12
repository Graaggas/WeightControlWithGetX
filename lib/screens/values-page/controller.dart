import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:weight_control/services/database.dart';

class ValuesController extends GetxController{

  var logger = Logger();

  final database = Database();

  var itemCounter = 0.obs;

  var listWeights = [].obs;

  var listDateTimes = [].obs;

  // var weightInCard = 0.0.obs;

  Future<void> getInfoForWeightAtValuesPage() async {
    getItemCounter();
    getWeightsList();
    getDateTimeList();
  }

  Future <void> getItemCounter () async {
    var r =  await database.getWeightsLength();
    itemCounter.value = r;
    // logger.w("itemCounter = ${itemCounter.value}");
  }

  // Future <void> getWeightInCard (DateTime key) async {
  //   double r =  await database.getWeightInCard(key);
  //   weightInCard.value = r;
  //   logger.w("weight in card = $weightInCard");
  //   // logger.w("itemCounter = ${itemCounter.value}");
  // }

  Future <void> getWeightsList () async {
    List<double> res = await database.getWeightsAsList();
    print("in controller res = $res, type = ${res.runtimeType}");
    listWeights.assignAll(res);
    print("in controller listWeights = $listWeights, type = ${listWeights.runtimeType}");
  }

  Future <void> getDateTimeList () async {
    List<DateTime> res2 = await database.getDatesAsList();
    print("in controller res2 = $res2, type = ${res2.runtimeType}");
    listDateTimes.assignAll(res2);
    print("in controller listWeights /dateTime/ = $listDateTimes, type = ${listDateTimes.runtimeType}");
  }
  Future<void> deleteWeight(DateTime key) async {
  await database.deleteWeight(key);
  getInfoForWeightAtValuesPage();
  }

  Future<void> changeOneWeight(double newWeight, DateTime key) async {
    await database.changeOneWeight(newWeight, key);
    getInfoForWeightAtValuesPage();
  }
}