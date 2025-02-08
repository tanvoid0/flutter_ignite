import 'dart:io';
import 'dart:isolate';

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_ignite/flutter_ignite_package.dart';

class Pen {
  // TODO: make use of logger package
  static final AnsiPen pen = AnsiPen();

  static void log(final String data) {
    write(data, type: PenType.info);
  }

  static void success(final String data) {
    write(data, type: PenType.success);
  }

  static void error(final String data) {
    write(data, type: PenType.error);
  }

  static void warning(final String data) {
    write(data, type: PenType.warning);
  }

  static void write(final String data,
      {final PenType type = PenType.info, final bool log = false}) {
    late final AnsiPen color;
    if (type == PenType.info) {
      color = PenColors.blue;
    } else if (type == PenType.debug || type == PenType.warning) {
      color = PenColors.yellowBold;
    } else if (type == PenType.print) {
      color = PenColors.white;
    } else if (type == PenType.success) {
      color = PenColors.greenBold;
    } else if (type == PenType.error) {
      color = PenColors.redBold;
    } else {
      color = PenColors.whiteBold;
    }

    final String formattedData = "${DateTime.now().toIso8601String()} [${type.name.padRight(7)}] : $data\n";

    if (kDebugMode) {
      debugPrint(color(formattedData));
    }

    if (!kDebugMode || log || FlutterIgnite.logToFile) {
      saveLog(formattedData);
      // _writeLogFile(
      //     "${DateFormat('dd-MM-yyyy - kk:mm-ss').format(DateTime.now())} : $data");
    }
  }

  static void writeLog(final String message) {
    final DateTime now = DateTime.now();

    final File file = File("app-traces-${DateFormat('dd-MM-yyyy').format(now)}.log");
    file.writeAsStringSync(message, mode: FileMode.append);
    // SystemUtils.saveAsBytes(message,
    //     type: FileType.text, mode: FileMode.append, path: 'app_traces.log');
  }

  static Future<void> saveLog(final String message) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(writeLog, message);

    // wait for the isolate to finish it's last task
    await receivePort.first;
  }
}

enum PenType { info, debug, print, success, error, warning }

class PenColors {
  static final white = Pen.pen..white();
  static final whiteBold = Pen.pen..white(bold: true);

  static final red = Pen.pen..red();
  static final redBold = Pen.pen..red(bold: true);

  static final blue = Pen.pen..blue();
  static final blueBold = Pen.pen..blue(bold: true);

  static final yellow = Pen.pen..yellow();
  static final yellowBold = Pen.pen..yellow(bold: true);

  static final green = Pen.pen..green();
  static final greenBold = Pen.pen..green(bold: true);
}
