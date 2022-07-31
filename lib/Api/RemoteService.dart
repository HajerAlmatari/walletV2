import 'package:walletapp/Models/SubAccount.dart';

import '../Models/User.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static String BASE_URL = "https://walletv1.azurewebsites.net/api/";

  Future<List<SubAccount>> getAllSubAccount(int accountId) async {
    try {
      String accountIdS = accountId.toString();
      print(accountIdS);
      var client = http.Client();

      var uri = Uri.parse(
          "${BASE_URL}SubAccount/getSubByAccountId?accountId=" + accountIdS);
      print(uri.toString());
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
