import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'pages/hooked_bloc_example_page.dart';
import 'pages/miscellaneous_hooks_demo.dart';
import 'pages/object_binding_hooks_demo_page.dart';
import 'cubit.dart';
import 'pages/hooks_demo_page.dart';

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SimpleCubitFactory().create()),
        BlocProvider(create: (_) => SimpleCubit()),
        BlocProvider(create: (_) => SimpleCubitA()),
        BlocProvider(create: (_) => SimpleCubitB()),
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => EventCubit()),
        BlocProvider(create: (_) => MessageActionCubit()),
      ],
      child: const MyApp(),
    ),
  );
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
    const HookedBlocExamplePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HookedBlocExamplePage(),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 12,
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
            label: 'Miscell.',
          ),
        ],
      ),
    );
  }
}
