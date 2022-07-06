import 'package:walletapp/Models/SubAccount.dart';

import '../Models/User.dart';
import 'package:http/http.dart' as http;

class RemoteService{


  static String BASE_URL = "http://192.168.1.101:7025/api/";
  int accountId = 100057542;

  Future<List<SubAccount>> getAllSubAccount(int accountId) async {
    try {
      String accountIdS= accountId.toString();

      var client = http.Client();

      var uri = Uri.parse("${BASE_URL}SubAccount/getSubByAccountId/{$accountIdS}");
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var json = response.body;

        return subAccountFromJson(json);
      }
      return subAccountFromJson("Error");
    } catch (e) {
      print(e);
      return subAccountFromJson(e.toString());
    }
  }

}