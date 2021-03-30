import 'dart:developer';

import 'package:weight_control/misc/custom_trace.dart';

class Logger {
  void info(String name, var value, StackTrace sT) {
    CustomTrace _trace = CustomTrace(sT);

    print(
        "===================================================\nfun = ${_trace.functionName}, caller = ${_trace.callerFunctionName}, path = ${_trace.fileName}\n***************************************************\n$name = $value\n===================================================");
  }

  void warning(String name, var value, StackTrace sT) {
    CustomTrace _trace = CustomTrace(sT);

    print(
        "===================================================\n⛔fun = ${_trace.functionName}, caller = ${_trace.callerFunctionName}, path = ${_trace.fileName}\n***************************************************\n$name = $value\n===================================================");
  }
}

String r = '🤔💥😡🔵⚪🔥⚡⛔';
