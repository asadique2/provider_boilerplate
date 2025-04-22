class SessionManager {
  bool _isLoggedIn = false;

  get baseRate => _isLoggedIn;

  set baseRate(value) => _isLoggedIn = value;

  static SessionManager? _instance;

  static SessionManager getInstance() {
    return _instance ??= SessionManager._internal();
  }

  SessionManager._internal();
}
