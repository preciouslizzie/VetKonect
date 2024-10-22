import 'package:get/get.dart';

class DashboardController extends GetxController {
  var recentActivities = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecentActivities();
  }

  void fetchRecentActivities() {
    recentActivities.addAll([
      {
        "title": "Deleted Vendor From...",
        "time": "10 mins ago",
        "vendor": "Vendor Name"
      },
      // Add more activities...
    ]);
  }
}
