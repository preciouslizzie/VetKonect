// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../User_sign_up/sucess_alert_screen.dart';
// import 'sign_up_controller.dart';

// class VetCreateAcctScreen extends StatelessWidget {
//   final ProffSignUpController signUpController =
//       Get.find<ProffSignUpController>();

//   final TextEditingController facebookController = TextEditingController();
//   final TextEditingController twitterController = TextEditingController();

//   VetCreateAcctScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Professional Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) => signUpController.vetNumber.value = value,
//                 decoration: const InputDecoration(
//                   labelText: 'Practicing License Number',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 onChanged: (value) =>
//                     signUpController.phoneNumber.value = value,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: facebookController,
//                 decoration: const InputDecoration(
//                   labelText: 'Facebook Handle',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: twitterController,
//                 decoration: const InputDecoration(
//                   labelText: 'Twitter Handle',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Obx(
//                 () => signUpController.isLoading.value
//                     ? const Center(child: CircularProgressIndicator())
//                     : ElevatedButton(
//                         onPressed: () async {
//                           if (signUpController.vetNumber.value.isEmpty ||
//                               signUpController.phoneNumber.value.isEmpty) {
//                             Get.snackbar(
//                               'Error',
//                               'Please fill all required fields',
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: Colors.redAccent,
//                               colorText: Colors.white,
//                             );
//                             return;
//                           }

//                           // Call Stage Two Sign-Up Method
//                           await signUpController.registerVeterinarianStageTwo();

//                           // Navigate to Success Screen on Success
//                           if (!signUpController.isLoading.value) {
//                             Get.to(() => const SuccessAlertScreen());
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(double.infinity, 50),
//                         ),
//                         child: const Text(
//                           'Proceed',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text('Back'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
