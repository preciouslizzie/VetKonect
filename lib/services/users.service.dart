import 'package:get/get.dart';

class UsersService extends GetxService {
  final x = 33.obs;

  final user = Rx<UserData>(UserData());

}


class UserData {
  final String name = 'Test user';
  final String avatar = 'https://api.dicebear.com/9.x/adventurer/png?seed=Annie';
  final String email = 'test.example.com';
  /// ...
}