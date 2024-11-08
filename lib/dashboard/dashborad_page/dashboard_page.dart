import 'package:flutter/material.dart';
import 'package:vet_konect/core/drawer%20Menu/MyStoreScreen.dart';
import 'package:vet_konect/dashboard/dashborad_page/drawer_menu.dart';
import 'package:vet_konect/feed_calculator/feed_calculator_screen.dart';
import 'package:vet_konect/Dasboard_Search/search/search_screen.dart';
import 'package:vet_konect/core/drawer%20Menu/setting/setting_screen.dart';
import '../../homepage/button_navigation.dart';
import 'dashbord_content.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Pages corresponding to each tab
  final List<Widget> _pages = [
    DashboardContent(),
    SearchScreen(),
    MyStoreScreen(),
    FeedCalculatorScreen(),
    SettingScreen(),
  ];

  // Titles for each page
  final List<String> _titles = [
    'Dashboard',
    'Search',
    'My Store',
    'Feed Calculator',
    'Settings',
  ];

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
      drawer: Drawer(
        child: DrawerMenu(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: _onTabTapped,
      ),
    );
  }
}
