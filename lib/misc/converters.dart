import 'package:intl/intl.dart';

String convertFromDateTimeToString(DateTime date) =>
    DateFormat("dd.MM.yyyy").format(date).toString();

double convertDoubleToString(String text){
  var r = double.parse(text);
  assert(r is double);
  return r;

}