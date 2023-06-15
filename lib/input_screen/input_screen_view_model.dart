import 'dart:convert';

import '../api/api_calls.dart';

class InputScreenViewModel {
  static double conversionFactor = 1646.11;
  static bool hasError = false;
  static String errorMessage = '';

  getConversionFactor() async {
    int? statusCode;
    String? jsonResponseString;

    (statusCode, jsonResponseString) = await ApiCalls().getExchangeRate();
    if (statusCode == 200) {
      var jsonDecoded = jsonDecode(jsonResponseString!);
      conversionFactor = jsonDecoded['rates']['usd']['value'] /
          jsonDecoded['rates']['eth']['value'];
    } else {
      if (statusCode == -1) {
        hasError = true;
        errorMessage =
            "No internet connection, couldn't fetch the value of conversion factor";
      } else {
        hasError = true;
        errorMessage =
            "Some error occurred, couldn't fetch the value of conversion factor";
      }
    }
  }
}
