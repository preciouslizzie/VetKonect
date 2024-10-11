import 'package:flutter/material.dart';

class TrendingForumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildForumItem("Forum Post 1", "Author Name", "2 hrs ago"),
        _buildForumItem("Forum Post 2", "Author Name", "3 hrs ago"),
        _buildForumItem("Forum Post 3", "Author Name", "4 hrs ago"),
      ],
    );
  }

  Widget _buildForumItem(String title, String author, String time) {
    return ListTile(
      title: Text(title),
      subtitle: Text("by $author"),
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
    );
  }
}
