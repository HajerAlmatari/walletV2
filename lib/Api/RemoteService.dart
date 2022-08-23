
import 'package:walletapp/Models/ClientName.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/transactions.dart';

import '../Models/User.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static String BASE_URL = "https://walletv1.azurewebsites.net/api/";

  Future<List<SubAccount>> getAllSubAccount(int accountId) async {
    try {
      String accountIdS = accountId.toString();
      print("Account ID from Remot Services $accountIdS");
      var client = http.Client();

      var uri = Uri.parse(
          "${BASE_URL}SubAccount/getSubByAccountId?accountId=" + accountIdS);
      print(uri.toString());
      var response = await client.get(uri);


      print("Repos body from Remot Services ");
      print(response.body);

      print("Code from Remot Services ");
      print(response.statusCode);

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



  Future<List<Transactions>> getTransactions(int accountId) async {
    try {
      var client = http.Client();

      var uri = Uri.parse(
          "${BASE_URL}transaction/" + accountId.toString());

      print(uri.toString());
      var response = await client.get(uri);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var json = response.body;

        return transactionsFromJson(json);
      }
      else
        {
          return transactionsFromJson("Error");

        }


    } catch (e) {
      print(e);
      print("error from transaction history");
      return transactionsFromJson(e.toString());
    }
  }


  Future<List<Transactions>> getPendingTransactions(int accountId) async {
    try {
      var client = http.Client();

      var uri = Uri.parse(
          "${BASE_URL}Cancle/" + accountId.toString());

      print(uri.toString());
      var response = await client.get(uri);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var json = response.body;

        return transactionsFromJson(json);
      }
      else
        {
          return transactionsFromJson("Error");

        }


    } catch (e) {
      print(e);
      print("error from transaction history");
      return transactionsFromJson(e.toString());
    }
  }

/*
  Future<ClientName> getName(String phone) async {
    try {
      var client = http.Client();


      var uri = Uri.parse(
          "${BASE_URL}BankServices/"+phone);
      print(uri.toString());
      var response = await client.get(uri);


      print("Repos body from Remot Services ");
      print(response.body);

      print("Code from Remot Services ");
      print(response.statusCode);

      if (response.statusCode == 200) {
        var json = response.body;

        return ClientNameFromJson(json);
      }
      return ClientNameFromJson("Error");
    } catch (e) {
      print(e);
      return ClientNameFromJson(e.toString());
    }
  }
*/

  //
  // Future<ClientName> fetchName(String Account) async {
  //
  //   var client = http.Client();
  //   var uri = Uri.parse("${BASE_URL}BankServices/"+Account);
  //   print(uri.toString());
  //
  //
  //   var response = await client.get(uri);
  //   print("Response Code From Fetch Name "+response.statusCode.toString());
  //   print("Response Body From Fetch Name "+response.body.toString());
  //
  //
  //   try{
  //     if (response.statusCode == 200) {
  //       // If the server did return a 200 OK response,
  //       // then parse the JSON.
  //       var json = response.body;
  //
  //       return clientNameFromJson(json);
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       return clientNameFromJson("Error");
  //     }
  //   }catch(e){
  //     return clientNameFromJson(e.toString());
  //   }
  //
  //
  // }

}
