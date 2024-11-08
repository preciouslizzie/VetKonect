import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_controller.dart';

class ClientsScreen extends StatelessWidget {
  final webViewController = Get.put(WebViewControllerGetX());

   ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Screen"),
      ),
      body: WebViewWidget(controller: _createWebViewController()),
    );
  }

  WebViewController _createWebViewController() {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            webViewController.hideTopSection();
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.vetkonect.com/animal-owner-clients')); 
    webViewController.setWebViewController(controller);
    return controller;
  }
}
