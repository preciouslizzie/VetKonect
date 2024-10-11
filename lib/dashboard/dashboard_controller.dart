import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Use this controller to manage state for the dashboard
  var recentActivities = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecentActivities();
  }

  void fetchRecentActivities() {
    // Fetch recent activities from backend or local storage
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
