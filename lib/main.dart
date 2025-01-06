import 'dart:async';

import 'package:ascii_generrator/app.dart';
import 'package:common_tools/utils/logs.dart';
import 'package:flutter/material.dart';

void main() {
  printLog('[main] ===== START main.dart =======');
  /// -------- 在其自己的错误区域中运行body ------------///
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const App());
  },printError);
}