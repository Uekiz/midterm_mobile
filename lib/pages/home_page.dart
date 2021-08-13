import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm_mobile/boxes.dart';
import 'package:midterm_mobile/main.dart';
import 'package:midterm_mobile/models/lasttime.dart';
import 'package:intl/intl.dart';

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
    return MyScaffold(
        route: '/',
        body: ValueListenableBuilder<Box<LastTime>>(
            valueListenable: Boxes.getLastTime().listenable(),
            builder: (context, box, _) {
              final lasttimelist = box.values.toList().cast<LastTime>();

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: lasttimelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        final lasttime = lasttimelist[index];

                        final date = DateFormat.MMMMd().format(lasttime.lastday);

                        return Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            tilePadding:
                                EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            title: Text(
                              lasttime.title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(date),
                            trailing: Text(
                              lasttime.group,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}
