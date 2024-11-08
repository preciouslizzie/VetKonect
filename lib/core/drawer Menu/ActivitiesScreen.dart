import 'package:flutter/material.dart';

import '../../dashboard/dashborad_page/drawer_menu.dart';

class ActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the Activities Screen'),
      ),
    );
  }
}
