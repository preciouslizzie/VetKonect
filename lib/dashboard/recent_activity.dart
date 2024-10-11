import 'package:flutter/material.dart';

class RecentActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildActivityItem("Deleted Vendor From...", "10 mins ago", "Vendor Name"),
        _buildActivityItem("Liked a Forum...", "15 mins ago", "Topic"),
        _buildActivityItem("Case Closed", "20 mins ago", "Case Title - Case ID"),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
    );
  }
}
