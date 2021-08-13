import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:midterm_mobile/main.dart';
import 'package:midterm_mobile/models/lasttime.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<LastTime> lasttimelist = [];

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MyScaffold(route: '/', body: Text('home'),);
  }
}
