import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../dashboard/dashborad_page/drawer_menu.dart';
import 'web_view_controller.dart';

class DiseasePredictorScreen extends StatelessWidget {
  const DiseasePredictorScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Screen'),
      ), 
      drawer: DrawerMenu(),
      body: WebViewWidget(controller: controller),
  );
  }
}
