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
  static final List<String> items = <String>[
    'none',
    'งานประจำ',
    'งานไม่ประจำ',
  ];

  String value = items.first;

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
              var lasttimelist = box.values.toList().cast<LastTime>();

              if(value != 'none')
              lasttimelist = box.values.where((element) => element.group == value).toList().cast<LastTime>();

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Filter by',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      buildDropdown(),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: lasttimelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        final lasttime = lasttimelist[index];

                        final date = DateFormat.Md().format(lasttime.lastday);

                        return Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            title: Text(
                              lasttime.title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text('ทำครั้งล่าสุดเมื่อ : $date'),
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

  Widget buildDropdown() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: 175,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value, // currently selected item
            items: items
                .map((item) => DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      value: item,
                    ))
                .toList(),
            onChanged: (value) => setState(() {
              this.value = value ?? '';
            }),
          ),
        ),
      ),
    );
  }
}
