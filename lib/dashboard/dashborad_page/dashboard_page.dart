import 'package:flutter/material.dart';
import '../../core/Animal_Owner Menu/feed_calculator_screen.dart';
import '../../core/Animal_Owner Menu/messages.dart';
import '../../core/Animal_Owner Menu/setting/setting_screen.dart';
import '../button_navigation.dart';
import 'dashbord_content.dart';
import '../../core/Animal_Owner Menu/drawer_menu.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic> userDetails; // Accept user details as a parameter

  const DashboardScreen({super.key, required this.userDetails});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // List of pages corresponding to each tab
  late final List<Widget> _pages;

  // Titles for each page
  final List<String> _titles = [
    'Dashboard',
    'Messages',
    'Feed Calculator',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardContent(userDetails: widget.userDetails),
       MessageScreen(),
       FeedCalculatorScreen(),
      const SettingScreen(),
    ];
  }

  // Handle tab selection
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const Drawer(
        child: DrawerMenu(),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
