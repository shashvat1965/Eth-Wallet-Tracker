import 'dart:convert';
import 'dart:math';

import 'package:cypherock_task/api/api_calls.dart';
import 'package:cypherock_task/input_screen/input_screen_view_model.dart';

class PortfolioViewModel {
  static double balanceETH = 0;
  static double balanceUSD = 0;
  static bool hasError = false;
  static String errorMessage = "";

  calculateBalance() async {
    int? statusCode;
    String? jsonResponseString;

    // get balance
    (statusCode, jsonResponseString) = await ApiCalls().getBalance();
    if (statusCode == 200) {
      var jsonDecoded = jsonDecode(jsonResponseString!);
      if (jsonDecoded['status'] == "1") {
        balanceETH = double.parse(jsonDecoded['result']) / pow(10, 18);
        balanceUSD = balanceETH * InputScreenViewModel.conversionFactor;
        balanceETH = double.parse(balanceETH.toStringAsFixed(
            2)); // truncating to reduce the number of place after decimals
        balanceUSD = double.parse(balanceUSD.toStringAsFixed(2));
      } else {
        hasError = true;
        errorMessage = jsonDecoded['result'];
      }
    } else {
      if (statusCode == -1) {
        hasError = true;
        errorMessage = "No Internet Connection";
      } else {
        hasError = true;
        errorMessage = "Some Error Occurred";
      }
    }
  }
}
