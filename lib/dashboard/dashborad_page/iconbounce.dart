// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class IconBounceScreen extends StatefulWidget {
//   const IconBounceScreen({super.key});

//   @override
//   _IconBounceScreenState createState() => _IconBounceScreenState();
// }

// class _IconBounceScreenState extends State<IconBounceScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//       lowerBound: 0.8,
//       upperBound: 1.2,
//     );

//     WidgetsBinding.instance.addPostFrameCallback((_) => _startBounce());
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _startBounce() async {
//     await _controller.forward();
//     await _controller.reverse();

//     Get.offNamed('/onboard');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _controller.value,
//               child: child,
//             );
//           },
//           child: SizedBox(
//             height: 100,
//             width: 100,
//             child: Image.asset(
//               'assets/images/new_logo.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
