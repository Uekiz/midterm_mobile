import 'package:flutter/material.dart';
import 'package:midterm_mobile/pages/home.dart';
import 'package:midterm_mobile/pages/second.dart';
import 'package:midterm_mobile/pages/third.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile',
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
  // print('test');
  print(uri);

  if (uri.path == '/') {
    return MyHomePage(title: 'Mobile');
  } else if (uri.path == '/second') {
    return SecondPage();
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
    if(widget.route == '/'){
      _currentIndex = 0;
    }else if(widget.route == '/second'){
      _currentIndex = 1;
    }else if(widget.route == '/third'){
      _currentIndex = 2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Mobile'),
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
      ),
    );
  }

  void onTapTapped(int value) {
    String navigate = '/';
    switch(value){
      case 0: navigate = '/';
      break;
      case 1: navigate = '/second';
      break;
      case 2: navigate = '/third';
      break;
    }
    setState(() {
      Navigator.of(context).pushNamed(navigate);
    });
  }
}

