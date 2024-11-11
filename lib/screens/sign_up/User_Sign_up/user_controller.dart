import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserTypeController extends GetxController {
  var selectedUserType = ''.obs;
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var selectedImagePath = ''.obs;
  var stage = 1;

  // Method to set the user type and call the backend
  Future<void> setUserType(String userType) async {
    selectedUserType.value = userType;
    print('User type set to: $userType');

    isLoading.value = true; // Start loading indicator

    try {
      var response = await http.post(
        Uri.parse(
            'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('User type successfully sent to the backend');
        print('Response data: ${response.body}');
      } else {
        print(
            'Failed to send user type to the backend: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error calling the backend: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

// Future<void> signUpStage1() async {
//   if (email.value.isEmpty || password.value.isEmpty) {
//     Get.snackbar('Error', 'Email and password cannot be empty.');
//     return;
//   }

//   isLoading(true);
//   try {
//     var response = await ApiService().post(
//         'https://vetkonect.com/backend/public/api/web/v2/registerAnimalOwner',
//         {"email": email.value, "password": password.value},
//         Client(),
//         "");
//     Get.snackbar('Success', 'Login Successful');
//     Get.offAllNamed('/dashboard');
//     debugPrint(response.body);
//     // if (response.body['code'] == 200) {
//     //   Get.snackbar('Success', 'Login Successful');
//     //   Get.offAllNamed('/dashboard');
//     //   if (rememberMe.value) {
//     //     box.write('email', email.value);
//     //     box.write('password', password.value);
//     //     box.write('rememberMe', true);
//     //   } else {
//     //     box.remove('email');
//     //     box.remove('password');
//     //     box.write('rememberMe', false);
//     //   }
//     // } else {
//     //   Get.snackbar('Error', 'invalid Email or Password');
//     // }

//     //  var decoded = UserModel.fromJson(json.decode(response.body));
//   } catch (e) {
//     Get.snackbar('Error', 'Please check your network and try again');
//   } finally {
//     isLoading(false);
//   }
// }
