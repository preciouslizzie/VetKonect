import 'package:get/get.dart';

class ActivityController extends GetxController {
  var activities = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  void loadActivities() {
    activities.value = [
      {"title": "Deleted Vendor From...", "subtitle": "Vendor Name", "timeAgo": 10},
      {"title": "Liked a Forum...", "subtitle": "Topic", "timeAgo": 15},
      {"title": "Case Closed", "subtitle": "Case Title - Case ID", "timeAgo": 20},
    ];
  }

  void updateLastSeen(int index) {
    activities[index]['timeAgo'] = 0;
    activities.refresh();
  }
}
