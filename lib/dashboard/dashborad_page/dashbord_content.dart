import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../card_slider.dart';
import '../recent_activity/recent_activity.dart';
import '../recent_activity/recent_activity_controller.dart';
import '../trending_forum.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key, required Map<String, dynamic> userDetails});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityController());

    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardSliderWidget(),
          SizedBox(height: 20),
          Text(
            'Recent Activities',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          RecentActivityWidget(),
          SizedBox(height: 20),
          Text('Forum Trending...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TrendingForumWidget(),
        ],
      ),
    );
  }
}
