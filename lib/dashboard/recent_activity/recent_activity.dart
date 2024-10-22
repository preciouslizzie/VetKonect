import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recent_activity_controller.dart';

class RecentActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActivityController controller = Get.find<ActivityController>();

    return Obx(() {
      return Column(
        children: controller.activities.map((activity) {
          int index = controller.activities.indexOf(activity);
          return GestureDetector(
            onTap: () => controller.updateLastSeen(index), 
            child: ActivityCard(
              title: activity["title"],
              subtitle: activity["subtitle"],
              timeAgo: activity["timeAgo"],
            ),
          );
        }).toList(),
      );
    });
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int timeAgo;

  ActivityCard({required this.title, required this.subtitle, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            
            LastSeenWidget(timeAgo: timeAgo),
          ],
        ),
      ),
    );
  }
}

class LastSeenWidget extends StatelessWidget {
  final int timeAgo; // Minutes ago

  LastSeenWidget({required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    String lastSeenText;
    if (timeAgo == 0) {
      lastSeenText = "Online";
    } else {
      lastSeenText = "$timeAgo mins ago";
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        lastSeenText,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}
