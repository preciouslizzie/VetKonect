import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'new_livestock_page.dart';
import 'new_pets_page.dart';
import 'tab_conroller.dart';

class TabBarViewContent extends StatelessWidget {
  final TabController _tabController = Get.find();
  final TabControllerX tabControllerX = Get.find();  
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildContent(),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          // Dynamic text and navigation based on the active tab
          String buttonText = tabControllerX.isPetsTab.value ? 'Add New Pet' : 'Add New LiveStock';
          return GestureDetector(
            onTap: () {
              if (tabControllerX.isPetsTab.value) {
                Get.to(() => AddNewPetPage());
              } else {
                Get.to(() => AddNewLiveStockPage());
              }
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }),
        Spacer(),
        _buildPagination(),
      ],
    );
  }

  Widget _buildPagination() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.first_page, color: Colors.grey),
        SizedBox(width: 8),
        Icon(Icons.navigate_before, color: Colors.grey),
        SizedBox(width: 8),
        Text("8", style: TextStyle(fontSize: 16)),
        SizedBox(width: 8),
        Icon(Icons.navigate_next, color: Colors.grey),
        SizedBox(width: 8),
        Icon(Icons.last_page, color: Colors.grey),
      ],
    );
  }
}
