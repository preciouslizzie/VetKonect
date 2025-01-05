import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../screens/User_sign_up/User_Sign_up/user_controller.dart';

class UserProfilePage extends StatefulWidget {
  final UserTypeController signUpController = Get.put(UserTypeController());
   UserProfilePage({super.key, required Map<String, String> userDetails});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    const String url =
        "https://vetkonect.com/backend/public/api/web/v2/getUserDetails";
    final UserTypeController signUpController = Get.find<UserTypeController>();

    try {
      final String? token = await signUpController.getAuthToken();
      debugPrint('Token at FetchUserData: $token');
      if (token == null) {
        debugPrint('No token found. Redirecting to login.');
        Get.offAllNamed('/login');
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody is Map<String, dynamic> &&
            responseBody.containsKey('data')) {
          if (mounted) {
            setState(() {
              userData = responseBody['data'];
              isLoading = false;
            });
          }
        } else {
          throw Exception('Unexpected response format.');
        }
      } else if (response.statusCode == 401) {
        debugPrint('Unauthorized. Token might be invalid.');
        Get.offAllNamed('/login');
      } else {
        final responseBody = jsonDecode(response.body);
        final error = responseBody is Map<String, dynamic> &&
                responseBody.containsKey('message')
            ? responseBody['message']
            : 'Failed to fetch user details.';
        Get.snackbar('Error', error, snackPosition: SnackPosition.BOTTOM);
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      Get.snackbar(
          'Error', 'An error occurred while fetching user details: $e');
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> logout() async {
    try {
      final UserTypeController signUpController =
          Get.put(UserTypeController());
      await signUpController.clearAuthToken();
      Get.offAllNamed('/login'); // Navigate to login screen
    } catch (e) {
      Get.snackbar('Error', 'Failed to log out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(
                  child: Text(
                    'No user data available.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: userData?['user_picture'] != null
                              ? NetworkImage(userData!['user_picture'])
                              : const AssetImage('assets/default_avatar.png')
                                  as ImageProvider,
                          child: userData?['user_picture'] == null
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User Name
                      ProfileInfoRow(
                        label: 'Name:',
                        value: userData?['user_name'] ?? 'N/A',
                      ),
                      const SizedBox(height: 10),

                      // Email
                      ProfileInfoRow(
                        label: 'Email:',
                        value: userData?['email'] ?? 'N/A',
                      ),
                      const SizedBox(height: 10),

                      // Phone
                      ProfileInfoRow(
                        label: 'Phone:',
                        value: userData?['phone_number'] ?? 'N/A',
                      ),
                      const SizedBox(height: 10),

                      // Role
                      ProfileInfoRow(
                        label: 'Role:',
                        value: userData?['user_role'] ?? 'N/A',
                      ),
                      const SizedBox(height: 10),

                      // Address
                      ProfileInfoRow(
                        label: 'Address:',
                        value: userData?['address'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),

                      // Logout Button
                      ElevatedButton(
                        onPressed: logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
