import 'package:walletapp/Models/SubAccount.dart';

class SubAccountNumbers {
  static List<SubAccount> subAccountsList2 = [];

  setSubAccountList( List<SubAccount> subAccountsList) {
    subAccountsList2 =subAccountsList;
  }


  getSubAccountList() {
    return subAccountsList2;
  }
}
