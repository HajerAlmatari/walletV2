class SaveClientDetails {
  static String client_first_name="";
  static String client_last_name="";
  static String client_email="";




  setFirstName(String fn) {
    client_first_name = fn;
  }


  getFirstName() {
    return client_first_name;
  }


  setLastName(String ln) {
    client_last_name = ln;
  }


  getLastName() {
    return client_last_name;
  }


  setEmail(String email) {
    client_email = email;
  }


  getEmail() {
    return client_email;
  }
}
