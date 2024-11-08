import 'package:flutter/material.dart';
import 'package:vet_konect/dashboard/dashborad_page/drawer_menu.dart';

import 'tab_view_content.dart';

class PetsLivestockScreen extends StatelessWidget {
  const PetsLivestockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerMenu(),
      body: TabBarViewContent()
    );
  }
}

