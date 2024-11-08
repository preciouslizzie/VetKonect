import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserTypeController extends GetxController {
  // Variable to hold the selected user type
  var selectedUserType = ''.obs;
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var selectedImagePath = ''.obs;

  // Method to set the user type and call the backend
  Future<void> setUserType(String userType) async {
    selectedUserType.value = userType;
    print('User type set to: $userType'); 

    try {
      var response = await http.post(
        Uri.parse('https://your-backend-url.com/api/setUserType'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userType': userType,
        }),
      );


      if (response.statusCode == 200) {
        print('User type successfully sent to the backend');
      } else {
        print('Failed to send user type to the backend: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling the backend: $e');
    }
  }
}


