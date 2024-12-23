import 'package:get/get.dart';

class DrawerController extends GetxController {
  var selectedMenuItem = 'Dashboard'.obs;

  void onMenuItemSelected(String item) {
    selectedMenuItem.value = item;

    switch (item) {
      case 'Dashboard':
        Get.toNamed('/dashboard');
        break;
      case 'Search':
        Get.toNamed('/search');
        break;
      case 'Feed Calculator':
        Get.toNamed('/feed_calculator');
        break;
      case 'Settings':
        Get.toNamed('/settings');
        break;
      default:
        Get.toNamed('/dashboard');
    }
  }
}
