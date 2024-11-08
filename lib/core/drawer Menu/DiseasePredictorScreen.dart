import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../dashboard/dashborad_page/drawer_menu.dart';

class DiseasePredictorScreen extends StatelessWidget {
  const DiseasePredictorScreen({super.key});
  
  get controller => null;

  

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
