import 'package:hive/hive.dart';
part 'lasttime.g.dart';

@HiveType(typeId: 0)
class LastTime extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String group;

  @HiveField(2)
  late DateTime lastday;
}