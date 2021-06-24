import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'package:learn_english/tab1.dart';
import 'package:learn_english/tab2.dart';
import 'package:learn_english/tab3.dart';
import 'package:learn_english/tab4.dart';

void main() => runApp(new App());

//MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabController = new DefaultTabController(
        length: 5,
        child: new Scaffold(
          appBar: new AppBar(
              title: new Text("Tab bar"),
              bottom: new TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 2,
                  tabs: [
                    new Tab(
                      icon: Icon(Icons.home),
                      text: "Home",
                    ),
                    new Tab(
                      icon: Icon(Icons.settings),
                      text: "Setting",
                    ),
                    new Tab(
                      icon: Icon(Icons.book),
                      text: "Book",
                    ),
                    new Tab(
                      icon: Icon(Icons.mail),
                      text: "Mail",
                    ),
                    new Tab(
                      icon: Icon(Icons.account_circle),
                      text: "Account",
                    )
                  ])),
          body: new TabBarView(children: [
            new Tab1(),
            new Tab2(),
            new Tab3(),
            new Tab4(),
            new Tab4()
          ]),
        ));
    return new MaterialApp(
      title: "Tabs",
      home: tabController,
    );
  }
}

//App
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new Tab1(),
    new Tab2(),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.amber),
    PlaceholderWidget(Colors.black)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Book'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
