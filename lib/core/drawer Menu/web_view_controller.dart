import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewControllerGetX extends GetxController {
  late WebViewController webViewController;

  void setWebViewController(WebViewController controller) {
    webViewController = controller;
    hideTopSection();
  }

  void hideTopSection() {
    const jsCode = """
      document.querySelector("btn").style.display = "none";
    """;
    webViewController.runJavaScript(jsCode);
  }
}
