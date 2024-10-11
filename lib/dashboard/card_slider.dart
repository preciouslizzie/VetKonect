import 'package:flutter/material.dart';

class CardSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView(
        children: [
          _buildCard("Search for what you need", "Browse our platform to discover vets, vet clinics, and vendors around you.", "assets/images/search_icon.png"),
          _buildCard("Find Vets", "Connect with veterinarians nearby.", "assets/images/pet_dull.png"),
          _buildCard("Locate Vendors", "Find vendors for all your animal needs.", "assets/images/vet_clinic.png"),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String description, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50),
            SizedBox(height: 20),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text(description, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
