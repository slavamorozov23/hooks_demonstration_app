import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_demonstration_app/pages/miscellaneous_hooks_demo.dart';
import 'package:hooks_demonstration_app/pages/object_binding_hooks_demo_page.dart';

import 'pages/hooks_demo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HooksDemoPage(),
    const ObjectBindingHooksDemoPage(),
    const MiscellaneousHooksDemo(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Hooks Demo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'Page Two',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages),
            label: 'Page Three',
          ),
        ],
      ),
    );
  }
}
