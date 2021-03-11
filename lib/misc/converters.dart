import 'package:intl/intl.dart';

String convertFromDateTimeToString(DateTime date) =>
    DateFormat("dd.MM.yyyy").format(date).toString();