import 'dart:async';

import 'package:qian_bai_du/app.dart';
import 'package:common_tools/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:qian_bai_du/home/chat_results_widget.dart';
import 'package:qian_bai_du/widgets/chat/chat_detail_widget.dart';

void main() {
  printLog('[main] ===== START main.dart =======');
  /// -------- 在其自己的错误区域中运行body ------------///
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const App());
  },printError);
}