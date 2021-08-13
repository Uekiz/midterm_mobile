import 'package:hive/hive.dart';
part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String group;

  @HiveField(2)
  late DateTime day;
}