import 'package:flutter/material.dart';
import 'package:vet_konect/Drawer/drawer%20Menu/MyStoreScreen.dart';
import 'package:vet_konect/dashboard/drawer_menu.dart';
import 'package:vet_konect/dashboard/trending_forum.dart';
import 'package:vet_konect/feed_calculator/feed_calculator_screen.dart';
import 'package:vet_konect/search/search_screen.dart';
import 'package:vet_konect/setting/setting_screen.dart';
import '../homepage/button_navigation.dart';
import 'card_slider.dart';
import 'recent_activity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;  // Track the selected tab index

  // List of pages for navigation
  final List<Widget> _pages = [
    DashboardScreen(),   
    SearchScreen(),         
    MyStoreScreen(),          
    FeedCalculatorScreen(), 
    SettingsScreen(),       
  ];

  // Handle tab change
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardSliderWidget(), // Keep your existing widgets
          const SizedBox(height: 20),
          const Text('Recent Activities',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          RecentActivityWidget(),
          const SizedBox(height: 20),
          const Text('Forum Trending...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TrendingForumWidget(),
        ],
      ),
    );
  }
}
