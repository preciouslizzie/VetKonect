import 'package:flutter/material.dart';
import 'package:vet_konect/config/assets.dart';

class CardSliderWidget extends StatelessWidget {
  const CardSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView(
        children: [
          _buildCard(
            "Search for what you need",
            "Browse our platform to discover vets, vet clinics, and vendors around you.",
            Assets.imgSearch,
            context,  
            "/search"
          ),
          _buildCard(
            "Find Vets",
            "Connect with veterinarians nearby.",
            Assets.imgPetCare,
            context,
            "/findVets" // replace with the appropriate route
          ),
          _buildCard(
            "Locate Vendors",
            "Find vendors for all your animal needs.",
            Assets.imgVetClinic,
            context,
            "/findVendors" // replace with the appropriate route
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String description, String imagePath, BuildContext context, String route) {
    return InkWell(
      onTap: () {
        // Navigate to the respective route when card is tapped
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 50),
              const SizedBox(height: 20),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
