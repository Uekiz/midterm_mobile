import 'package:hive/hive.dart';
import 'package:midterm_mobile/models/lasttime.dart';

class Boxes {
  static Box<LastTime> getTransactions() =>
      Hive.box<LastTime>('lasttimelist');
}
