import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  // Strings constants
  static const String AppLanguagesKey = 'language';
  static const String DarkModeKey = 'darkmode';
  static const String OnboardingSeen = 'onboardingseen';
  static const String UserId = 'userId';
  static const String Location = 'location';
  static const String ProfileModel = 'profileModel';
  static const String isLoggedInKey = 'isLoggedIn';

  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  String get profileModel => _getFromDisk(ProfileModel) ?? null;
  void setProfileModel(String value) => _saveToDisk(ProfileModel, value);

  bool get darkMode => _getFromDisk(DarkModeKey) ?? false;
  void setDarkMode(bool value) => _saveToDisk(DarkModeKey, value);

  bool get isLoggedIn => _getFromDisk(isLoggedInKey) ?? false;
  void setIsLogIn(bool value) => _saveToDisk(isLoggedInKey, value);

  bool get onBoardingSeen => _getFromDisk(OnboardingSeen) ?? false;
  void setOnboardingSeen(bool value) => _saveToDisk(OnboardingSeen, value);

  int get userId => _getFromDisk(UserId) ?? null;
  void setUserId(int value) => _saveToDisk(UserId, value);

  String get language => _getFromDisk(AppLanguagesKey) ?? 'en';
  void setLanguage(String value) => _saveToDisk(AppLanguagesKey, value);


  String get location => _getFromDisk(Location);
  void setLocation(String value)=> _saveToDisk(Location, value);
// updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences?.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
}
