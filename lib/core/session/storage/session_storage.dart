import 'package:hive/hive.dart';

class SessionStorage {
  Box sessionBox = Hive.box("session");
  saveAccessToken(String accessToken) async {
    // Box sessionBox = Hive.isBoxOpen("session")
    //     ? Hive.box("session")
    //     : await Hive.openBox("session");
    sessionBox.put("access_token", accessToken);
  }

  saveRefreshToken(String refreshToken) async {
    // Box sessionBox = Hive.isBoxOpen("session")
    //     ? Hive.box("session")
    //     : await Hive.openBox("session");

    sessionBox = await Hive.openBox("session");
    sessionBox.put("refresh_token", refreshToken);
  }

  String? getAccessToken() {
    String? accessToken = sessionBox.get("access_token");

    return accessToken;
  }
}
