import 'package:flutter/material.dart';

import '../../dashboard/dashborad_page/drawer_menu.dart';

class DiseasePredictorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the disease predictor Screen'),
      ),
    );
  }
}
