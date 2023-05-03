import 'package:flutter/material.dart';
import 'package:flutter_application_portfolio/my_dice.dart';
import 'package:flutter_application_portfolio/my_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  //하단 아이템들 배열
  List<BottomNavigationBarItem> items = [];

  late Widget bodyPage;
  List<dynamic> pages = [
    Scaffold(),
    MyTimer(),
    MyDice(),
    MyTimer(),
  ];
  void movePage(int page) {
    setState(() {
      _index = page;
      bodyPage = pages[page];
    });
  }

  @override
  void initState() {
    super.initState();
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.home), label: '홈', backgroundColor: Colors.pink));
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.timer_outlined),
        activeIcon: Icon(
          Icons.timer_outlined,
          color: Colors.blue,
        ),
        label: '타이머',
        backgroundColor: Colors.green));
    items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.checklist_rounded),
        activeIcon: Icon(
          Icons.checklist_rounded,
          color: Colors.amber,
        ),
        label: '뽑기',
        backgroundColor: Colors.blue));
    items.add(const BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.comment),
        label: '소개',
        backgroundColor: Colors.red));

    //첫페이지 지정
    bodyPage = Center(
      child: FaIcon(
        FontAwesomeIcons.delicious,
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: bodyPage,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              movePage(value);
            },
            currentIndex: _index,
            // type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.pink,
            items: items),
      ),
    );
  }
}
