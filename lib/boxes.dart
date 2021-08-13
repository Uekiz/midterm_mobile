import 'package:hive/hive.dart';
import 'package:midterm_mobile/models/lasttime.dart';

class Boxes {
  static Box<LastTime> getLastTime() =>
      Hive.box<LastTime>('lasttimelist');
}
