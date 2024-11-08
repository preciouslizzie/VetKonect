import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../card_slider.dart';
import '../recent_activity/recent_activity.dart';
import '../recent_activity/recent_activity_controller.dart';
import '../trending_forum.dart';

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ActivityController());


    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardSliderWidget(), 
          const SizedBox(height: 20),
          const Text(
            'Recent Activities',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          RecentActivityWidget(), 
          const SizedBox(height: 20),
          const Text('Forum Trending...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TrendingForumWidget(), 
        ],
      ),
    );
  }
}
