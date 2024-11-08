import 'package:flutter/material.dart';
import 'package:vet_konect/config/assets.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.lightBlue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            Assets.imgLogin,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 330,
          ),
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}