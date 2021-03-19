import 'package:get/get.dart';
import 'package:weight_control/model/weight/controllerDashboardInfo.dart';
import 'package:weight_control/services/database.dart';

class FirstMeetingController extends GetxController {
  final database = Database();

  var flagFirstMeeting = true.obs;
  // var wantedWeight = 0.0.obs;
  // var startWeight = 0.0.obs;

  @override
  Future<void> onInit() async {
    print("init FMController...");
  bool r = await database.getFlagFromHive();
  print("FMController... flag = $r");
  if (r == null){
    flagFirstMeeting.value = true;
    print("FMController. set flag as true");
  }
  else
    {
      flagFirstMeeting.value = r;
    }
    super.onInit();
  }

Future<bool> getFlag() async {
    return flagFirstMeeting.value;
}


  Future<void> changeFlagFirstMeeting() async {
    print("try to change flag in fmController..");
    print("FMcontroller. flag before changing : $flagFirstMeeting");
    await database.changeFlagMeeting();
    flagFirstMeeting.value = !flagFirstMeeting.value;
    print("FMcontroller. flag after changing : $flagFirstMeeting");
  }

  Future<void> putInitWeight({double startWeight1, double wantedWeight1}) async {
    // wantedWeight.value = wantedWeight1;
    // startWeight.value = startWeight1;
    print("in fmController. try to put start values via database... ");
    await database.addToWeightBox(valueWantedWeight: wantedWeight1, valueWeight: startWeight1);


  }
}
