import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:xpire/pages/history.dart';
import 'package:xpire/pages/home.dart';

import 'constants/shared.dart';
import 'pages/camera.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xpire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  final tabs = [
    Camera(),
    Home(),
    History()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: constAppBar,
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: tabs,
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          animationDuration: Duration(milliseconds:250 ),
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            iconSize: 30,
            containerHeight: 60,
            selectedIndex: _currentIndex,
            showElevation: true,
            itemCornerRadius: 30,
            onItemSelected: (index) => setState(() {
                  setState(() => _currentIndex = index);
                  _pageController.jumpToPage(index);
                }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.line_weight),
                title: Text(
                  'SCAN',
                  style: bottomnavStyle,
                  ),
                activeColor: pixelBlue,
                inactiveColor: Colors.grey[800]
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('HOME', style:bottomnavStyle),
                activeColor: pixelBlue,
                inactiveColor: Colors.grey[800]
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.history),
                title: Text(
                  'LOGS',
                  style: bottomnavStyle,
                ),
                activeColor: pixelBlue,
                inactiveColor: Colors.grey[800]
              ),
            ]));
  }
}
