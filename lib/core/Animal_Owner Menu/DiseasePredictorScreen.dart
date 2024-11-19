import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/core/Animal_Owner%20Menu/web_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async'; 

class DiseasePredictorScreen extends StatefulWidget {
  final webViewController = Get.put(WebViewControllerGetX());

  DiseasePredictorScreen({super.key});

  @override
  State<DiseasePredictorScreen> createState() => _DiseasePredictorScreenState();
}

class _DiseasePredictorScreenState extends State<DiseasePredictorScreen> {
  late WebViewController _webViewController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isLoading = true;
  bool _isConnected = true;

  final String hideElementsScript = """
    setTimeout(() => {
      document.querySelectorAll('.sidebar, .button, .menu').forEach(element => {
        element.style.display = 'none';
      });
    }, 1000); // Delay of 1 second to ensure elements are loaded
  """;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _webViewController = _createWebViewController();

    // Listen for connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((status) {
      setState(() {
        _isConnected = status != ConnectivityResult.none;
      });

      // Reload the page if connected and there was a previous network issue
      if (_isConnected) {
        _retryLoadingPage();
      }
    });
  }

  Future<void> _checkInitialConnectivity() async {
    var status = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = status != ConnectivityResult.none;
    });
  }

  void _retryLoadingPage() {
    if (_isConnected) {
      setState(() {
        _isLoading = true;
      });
      _webViewController.loadRequest(
        Uri.parse('https://www.vetkonect.com/animal-owner-disease-prediction'),
      );
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel(); // Dispose of the subscription to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disease Predictor",
          style: TextStyle(color: Color.fromARGB(255, 46, 129, 48)),
        ),
      ),
      body: Stack(
        children: [
          if (_isConnected)
            Positioned.fill(
              child: WebViewWidget(controller: _webViewController))
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('No internet connection. Please check your network.'),
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
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            _webViewController.runJavaScript(hideElementsScript);
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.vetkonect.com/animal-owner-disease-prediction'));
    return controller;
  }
}
