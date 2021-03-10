import 'package:get/get.dart';

class CheckController extends GetxController{
  var weightChecked = false.obs;
  var waisteChecked = false.obs;

  void changeWeightChecked () {
    weightChecked.value = !weightChecked.value;
  }
  void changeWaisteChecked () {
    waisteChecked.value = !waisteChecked.value;
  }

  bool get getWeightChecking => weightChecked.value;

  bool get getWaisteChecking => waisteChecked.value;

  void allCheckesSetFalse(){
    weightChecked.value = false;
    waisteChecked.value = false;
  }

}