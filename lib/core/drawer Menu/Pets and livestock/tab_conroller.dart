import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerX extends GetxController   {
  late TabController tabController;
  var isPetsTab = true.obs;

  @override
  void onInit() {
    super.onInit();

    tabController.addListener(() {
      if (tabController.index == 0) {
        isPetsTab.value = true;
      } else {
        isPetsTab.value = false;
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
