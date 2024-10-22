import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tab_conroller.dart';

class TabBarMenu extends StatelessWidget implements PreferredSizeWidget {
  final TabController _tabController = Get.put(TabController(length: 2, vsync: NavigatorState()));
  final TabControllerX tabControllerX = Get.put(TabControllerX());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          onTap: (index) {
            if (index == 0) {
              tabControllerX.isPetsTab.value = true;
            } else {
              tabControllerX.isPetsTab.value = false;
            }
          },
          tabs: const [
            Tab(text: "My Pets"),
            Tab(text: "LiveStock Farms"),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
