import 'package:hive/hive.dart';

part 'waiste_model.g.dart';

@HiveType(typeId: 2)
class WaisteModel extends HiveObject {
  @HiveField(1)
  Map<DateTime, double> _waisteMap = new Map();

  @HiveField(2)
  double _wantedWaiste;

  @HiveField(3)
  String _name;

  @HiveField(4)
  bool flagFirstMeeting;

  @HiveField(5)
  double _startWaisteForCalculating;

  @HiveField(6)
  double _height;


  void addStartWaisteForCalculating(double value) {
    _startWaisteForCalculating = value;
  }


  void addFlag(bool flag) {
    flagFirstMeeting = flag;
  }

  void changeFlag() {
    flagFirstMeeting = !flagFirstMeeting;
  }

  void addWaiste (double value) {
    DateTime dateTime = DateTime.now();
    _waisteMap[dateTime] = value;
  }

  void addHeight(double value){
    _height = value;
  }


  void addName(String name) {
    _name = name;
  }

  double get wantedWaiste => _wantedWaiste;

  Map get waiste => _waisteMap;

  double get height => _height;

  double lastCurrentWaiste() {
    double res = 0;
    for (var item in _waisteMap.entries) {
      res = item.value;
    }
    return res;
  }

  double setWantedWaiste(){
    double r = 0.0;
    r = 0.5*height;
    _wantedWaiste = r;
    print("||waiste_model||setWantedWaiste||\nwantedWaiste = ${_wantedWaiste}");
  }

}