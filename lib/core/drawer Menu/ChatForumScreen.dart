import 'package:flutter/material.dart';

import '../../dashboard/dashborad_page/drawer_menu.dart';

class ChatForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat Screen'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('This is the Chat Forum Screen'),
      ),
    );
  }
}
