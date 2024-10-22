import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Vet_Clinic/Vet_Clinic.dart';
import '../Vpp_Page/vpp.dart';
import '../vendor_Page/Vendor_page.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> users = []; 
  bool isLoading = true; 
  bool hasError = false; 

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
   // _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await dio.get('https://your-laravel-backend.com/api/users'); // To be Replaced with my actual API endpoint

      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(response.data); 
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      Get.snackbar('Error', 'Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Users')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
              children:  [
                Icon(
                  Icons.person, 
                  color: Colors.green, 
                ),
                Text(
                  'Veterinarian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, 
                  ),
                ),
                Icon(
                  Icons.check_circle, 
                  color: Colors.green,
                ),
              ],
            ),
              _buildCategoryButton('VPP', false, context, VPPPage()),
              _buildCategoryButton('Vendor', false, context, VendorPage()),
              _buildCategoryButton('Vet Clinic', false, context, VetClinicPage()),
            ],
          ),
          const SizedBox(height: 20),

          // Search Bar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by Location or Name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),

          // User Cards List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) 
                : hasError
                    ? const Center(child: Text('Failed to load users')) 
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return _buildUserCard(
                            name: user['name'] ?? 'N/A',
                            location: user['location'] ?? 'Unknown location',
                            phoneNumber: user['phone'] ?? 'N/A',
                            email: user['email'] ?? 'N/A',
                            rating: user['rating']?.toInt() ?? 0,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Method to build a category button
  Widget _buildCategoryButton(String label, bool isSelected, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.green[50] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Icon(
                  Icons.person, // Placeholder icon
                  color: isSelected ? Colors.green : Colors.black,
                ),
                Text(label),
              ],
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
        ],
      ),
    );
  }

  // Method to build a user card with image above the text
  Widget _buildUserCard({
    required String name,
    required String location,
    required String phoneNumber,
    required String email,
    required int rating,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), 
                  
                ),
                const SizedBox(height: 16), 
                
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location),
              ],
            ),
            SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.green),
                  onPressed: () => _makePhoneCall(phoneNumber),
                ),
                IconButton(
                  icon: Icon(Icons.email, color: Colors.blue),
                  onPressed: () => _sendEmail(email),
                ),
                IconButton(
                  icon: Icon(Icons.message, color: Colors.orange),
                  onPressed: () => _sendMessage(phoneNumber),
                ),
                IconButton(
                  icon: Icon(Icons.navigation, color: Colors.green),
                  onPressed: () => _navigateTo(location),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar('Error', 'Could not make phone call');
    }
  }

  // Method to send email
  void _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Contact&body=Hello',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      Get.snackbar('Error', 'Could not send email');
    }
  }

  // Method to send SMS
  void _sendMessage(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      Get.snackbar('Error', 'Could not send message');
    }
  }

  // Method to navigate to a location using Google Maps
  void _navigateTo(String location) async {
    final Uri mapsUri = Uri(
      scheme: 'https',
      path: 'www.google.com/maps/search/',
      queryParameters: {'query': location},
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      Get.snackbar('Error', 'Could not open maps');
    }
  }
}
