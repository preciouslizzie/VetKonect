
import 'package:vet_konect/config/assets.dart';

class UnbordingContent {
  String asset;
  String title;
  String discription;

  UnbordingContent({required this.asset, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Animal Health Professional',
    asset: Assets.imgAnimalHealth,
    discription: "Easily connect with Veterinarians and Paraprofessionals near you. "
  ),
  UnbordingContent(
    title: 'Locate Veterinary Clinic',
    asset: Assets.imgVetClinic,
    discription: "Access Veterinary clinics near you for your pets and livestock "
  ),
  UnbordingContent(
    title: 'Connect to Vendors',
    asset: Assets.imgPetCare,
    discription: "Connect to a pool of vendors for all of your animal needs or sell easily. "
  ),
];