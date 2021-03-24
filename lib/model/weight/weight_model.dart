import 'package:hive/hive.dart';

part 'weight_model.g.dart';

@HiveType(typeId: 1)
class WeightModel extends HiveObject {
  @HiveField(1)
  Map<DateTime, double> _weightMap = new Map();

  @HiveField(2)
  double _wantedWeight;

  @HiveField(3)
  String _name;

  @HiveField(4)
  bool flagFirstMeeting;

  @HiveField(5)
  double _startWeightForCalculating;

  void addFlag(bool flag) {
    flagFirstMeeting = flag;
  }

  void changeFlag() {
    flagFirstMeeting = !flagFirstMeeting;
  }

  void addWeight(double value) {
    DateTime dateTime = DateTime.now();
    _weightMap[dateTime] = value;
  }

  void addStartWeightForCalculating(double value) {
    _startWeightForCalculating = value;
  }

  void addWantedWeight(double value) {
    _wantedWeight = value;
  }

  void addName(String name) {
    _name = name;
  }

  double get wantedWeight => _wantedWeight;

  Map get weights => _weightMap;

  double lastCurrentWeight() {
    double res = 0;
    for (var item in _weightMap.entries) {
      res = item.value;
    }
    return res;
  }
}