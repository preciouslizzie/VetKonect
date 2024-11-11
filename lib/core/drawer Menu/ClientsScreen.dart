import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_konect/core/drawer%20Menu/web_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ClientsScreen extends StatefulWidget {
  final webViewController = Get.put(WebViewControllerGetX());

  ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
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
            Uri.parse('https://www.vetkonect.com/animal-owner-clients'));
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
        title: const Text("Client Screen"),
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Loading, please wait...'),
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
            // Use the class-level _webViewController to run JavaScript
            _webViewController.runJavaScript("""
              document.querySelector('.sidebar')[3].style.display = 'none';
            """);

            // Hide the loading indicator
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.vetkonect.com/animal-owner-clients'));

    return controller;
  }
}
