import '../Models/User.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  Future<User> getUser() async {
    try {
      var client = http.Client();

      var uri = Uri.parse("https://reqres.in/api/users/2");
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var json = response.body;

        return userFromJson(json);
      }
      return userFromJson("Error");
    } catch (e) {
      print(e);
      return userFromJson(e.toString());
    }
  }

   void hell(){
//dgadfbfgbgf
  }

  void hell1(){
//dgadfbfgbgf
  }

  void hell4(){
//dgadfbfgbgf
  }

}