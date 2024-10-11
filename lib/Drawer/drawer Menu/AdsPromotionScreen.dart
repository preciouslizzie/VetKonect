import 'package:flutter/material.dart';

import '../../dashboard/drawer_menu.dart';

class AdsPromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the Ads Screen'),
      ),
    );
  }
}
