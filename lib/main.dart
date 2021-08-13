import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:midterm_mobile/boxes.dart';
import 'package:midterm_mobile/models/history.dart';
import 'package:midterm_mobile/models/lasttime.dart';
import 'package:midterm_mobile/pages/home_page.dart';
import 'package:midterm_mobile/pages/history_page.dart';

import 'package:midterm_mobile/pages/third.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm_mobile/widget/lasttime_dialog.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LastTimeAdapter());
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<LastTime>('lasttimelist');
  await Hive.openBox<History>('history');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) {
              return _getPageWidget(settings: settings);
            });
      },
    );
  }
}

Widget _getPageWidget({required RouteSettings settings}) {
  final uri = Uri.parse(settings.name ?? '');
  print(uri);

  if (uri.path == '/') {
    return MyHomePage(title: 'Last Time');
  } else if (uri.path == '/history') {
    return HistoryPage(title: 'Last Time History');
  } else if (uri.path == '/third') {
    return ThirdPage();
  } else {
    return Container();
  }
}

class MyScaffold extends StatefulWidget {
  final String route;
  final Widget body;
  MyScaffold({required this.route, required this.body});
  @override
  _MyMainState createState() => _MyMainState();
}

class _MyMainState extends State<MyScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    if (widget.route == '/') {
      _currentIndex = 0;
    } else if (widget.route == '/history') {
      _currentIndex = 1;
    } else if (widget.route == '/third') {
      _currentIndex = 2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) =>
          window.location.href.contains('history') == false,
      widgetBuilder: (BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Last Time'),
        ),
        body: widget.body,
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => LastTimeDialog(
              onClickedDone: addLastTime,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
      fallbackBuilder: (BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Last Time'),
        ),
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
    );
  }

  void onTapTapped(int value) {
    String navigate = '/';
    switch (value) {
      case 0:
        navigate = '/';
        break;
      case 1:
        navigate = '/history';
        break;
      case 2:
        navigate = '/third';
        break;
    }
    setState(() {
      Navigator.of(context).pushNamed(navigate);
    });
  }
}

Future addLastTime(String title, String group) async {
  final lasttime = LastTime()
    ..title = title
    ..lastday = DateTime.now()
    ..group = group;

  final box = Boxes.getLastTime();
  box.add(lasttime);
}
