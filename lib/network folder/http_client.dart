import 'package:http/http.dart';

class AppHttpClient {
  static Client getHttpClient() {
    Client client = new Client();
    return client;
  }

  static String getCurentToken() {
    /*String token = AppConstants.sharedPreferences!
        .getString(AppConstants.userToken)
        .toString();*/
    return '';
  }
}
