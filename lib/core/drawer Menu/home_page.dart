import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/core/drawer%20Menu/web_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  final webViewController = Get.put(WebViewControllerGetX());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        _webViewController.loadRequest(
            Uri.parse('https://www.vetkonect.com/animal-owner-home')); 
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
        title: const Text("Home", 
        style: TextStyle(color: Color.fromARGB(255, 46, 129, 48)),),
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
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // Inject JavaScript to hide the sidebar on the Disease Predictor page
            _webViewController.runJavaScript("""
              document.querySelector('.sidebar').style.display = 'none';
            """);

            // Hide the loading indicator
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.vetkonect.com/animal-owner-home')); 
    return controller;
  }
}
