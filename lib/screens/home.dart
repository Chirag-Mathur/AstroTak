import 'package:flutter/material.dart';
import 'question.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Home',
      style: optionStyle,
    ),
    Text(
      'Index 2: Talk',
      style: optionStyle,
    ),
    QuestionScreen(),
    Text(
      'Index 4: Report',
      style: optionStyle,
    ),
    Text(
      'Index 5: Chat',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/talk.png"),
            ),
            label: 'Talk',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/ask.png"),
            ),
            label: 'Ask Question',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/reports.png"),
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/chat.png"),
            ),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
