import 'package:hive/hive.dart';
import 'package:midterm_mobile/models/history.dart';
import 'package:midterm_mobile/models/lasttime.dart';

class Boxes {
  static Box<LastTime> getLastTime() => Hive.box<LastTime>('lasttimelist');
  static Box<History> getHistory() => Hive.box<History>('history');
}
