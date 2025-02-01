import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'web_view_controller.dart';

class FeedCalculatorScreen extends StatefulWidget {
  final webViewController = Get.put(WebViewControllerGetX());

  FeedCalculatorScreen({super.key});

  @override
  State<FeedCalculatorScreen> createState() => _FeedCalculatorScreenState();
}

class _FeedCalculatorScreenState extends State<FeedCalculatorScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _webViewController = _createWebViewController();

    Connectivity().onConnectivityChanged.listen((status) {
      setState(() {
        _isConnected = status != ConnectivityResult.none;
      });

      if (_isConnected) {
        _webViewController.loadRequest(Uri.parse(
            'https://www.vetkonect.com/animal-owner-feed-calculator'));
      }
    });
  }

  Future<void> _checkInitialConnectivity() async {
    var status = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = status != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed Calclator"),
      ),
      body: Stack(
        children: [
          if (_isConnected)
            WebViewWidget(controller: _webViewController)
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                      'No internet connection. Please check your network.'),
                  ElevatedButton(
                    onPressed: _checkInitialConnectivity,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          if (_isLoading && _isConnected)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading, please wait...'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  WebViewController _createWebViewController() {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            Future.delayed(const Duration(milliseconds: 700), () {
              _webViewController.runJavaScript("""
                document.querySelectorAll('.flex.items-center.flex-col.gap-1').forEach(item => {
                  if (item) {
                    item.style.display = 'none';
                  }
                });
              """);
            });
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://www.vetkonect.com/animal-owner-feed-calculator'));

    return controller;
  }
}