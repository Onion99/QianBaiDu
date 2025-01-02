
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

/// ------------------------------------------------------------------------
/// 自定义日志输出
/// ------------------------------------------------------------------------
class CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(debugPrint);
  }
}
/// ------------------------------------------------------------------------
/// 日志实例化
/// ------------------------------------------------------------------------
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: !UniversalPlatform.isIOS,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  output: CustomOutput(),
);

/// ------------------------------------------------------------------------
/// 日志输出调用
/// ------------------------------------------------------------------------
void printLog([dynamic rawData, DateTime? startTime, Level? level]) {
  if (kDebugMode) {
    var time = '';
    if (startTime != null) {
      final endTime = DateTime.now().difference(startTime);
      final icon = endTime.inMilliseconds > 2000
          ? '⌛️Slow-'
          : endTime.inMilliseconds > 1000
          ? '⏰Medium-'
          : '⚡️Fast-';
      time = '[$icon${endTime.inMilliseconds}ms]';
    }

    try {
      final data = '$rawData';
      final log = '$time${data.toString()}';

      /// print log for ios
      if (UniversalPlatform.isIOS) {
        debugPrint(log);
        return;
      }

      /// print log for android
      switch (level) {
        case Level.error:
          printError(log, StackTrace.empty);
          break;
        case Level.warning:
          logger.w(log, stackTrace: StackTrace.empty);
          break;
        case Level.info:
          logger.i(log, stackTrace: StackTrace.empty);
          break;
        case Level.debug:
          logger.d(log, stackTrace: StackTrace.empty);
          break;
        case Level.trace:
          logger.t(log, stackTrace: StackTrace.empty);
          break;
        default:
          if (time.startsWith('[⌛️Slow-')) {
            logger.f(log, stackTrace: StackTrace.empty);
            break;
          }
          if (time.startsWith('[⏰Medium-')) {
            logger.w(log, stackTrace: StackTrace.empty);
            break;
          }
          logger.t(log, stackTrace: StackTrace.empty);
          break;
      }
    } catch (err, trace) {
      printError(err, trace);
    }
  }
}
/// ------------------------------------------------------------------------
/// 输出错误日志
/// ------------------------------------------------------------------------
void printError(dynamic err, [dynamic trace, dynamic message]) {
  if (!kDebugMode) return;
  final shouldHide = trace == null || '$trace'.isEmpty;
  if (shouldHide) {
    logger.d(err, error: message, stackTrace: StackTrace.empty);
    return;
  }
  logger.e(err, error: message ?? 'Stack trace:', stackTrace: trace);
}
