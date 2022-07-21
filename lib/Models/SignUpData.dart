class SignUpData {
  static String _firstName = "";
  static String _lastName = "";
  static String _email = "";
  static String _password = "";
  static String _phone = "";
  static bool _isNew = false;

  void setFirstName(String value) {
    _firstName = value;
  }

  String getFirstName() {
    return _firstName;
  }

  void setLastName(String value) {
    _lastName = value;
  }

  String getLastName() {
    return _lastName;
  }

  void setEmail(String value) {
    _email = value;
  }

  String getEmail() {
    return _email;
  }

  void setPassword(String value) {
    _password = value;
  }

  String getPassword() {
    return _password;
  }

  void setPhone(String value) {
    _phone = value;
  }
  String getPhone() {
    return _phone;
  }
  void setIsNew(bool value) {
    _isNew = value;
  }

  bool getIsNew() {
    return _isNew;
  }
}
