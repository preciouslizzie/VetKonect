import 'package:get/get.dart';

class ProffesionalController extends GetxController {
  var userType = ''.obs;
  var professionalType = ''.obs;
  
  void setUserType(String type) {
    userType.value = type;
  }

  void setProfessionalType(String type) {
    professionalType.value = type;
  }

  void clearSelections() {
    userType.value = '';
    professionalType.value = '';
  }
}