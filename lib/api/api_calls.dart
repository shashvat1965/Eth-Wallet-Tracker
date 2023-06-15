import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiCalls {
  static String baseUrlEtherScan = "https://api.etherscan.io/api";
  static String baseUrlCoinGecko = 'https://api.coingecko.com/api/v3';
  static String address = "";

  var client = http.Client();

  Future getBalance() async {
    try {
      var url = Uri.parse(
          "$baseUrlEtherScan?module=account&action=balance&address=$address&tag=latest&apiKey=${dotenv.env['API_KEY']}");
      var response = await client.get(url);
      return (response.statusCode, response.body);
    } catch (e) {
      debugPrint(e.toString());
      return (-1, null);
    }
  }

  Future getExchangeRate() async {
    try {
      var url = Uri.parse("$baseUrlCoinGecko/exchange_rates");
      var response = await client.get(url);
      return (response.statusCode, response.body);
    } catch (e) {
      debugPrint(e.toString());
      return (-1, null);
    }
  }

  Future getNormalTransactionHistory() async {
    try {
      var url = Uri.parse(
          "$baseUrlEtherScan?module=account&action=txlist&address=$address&startblock=0&endblock=99999999&page=1&offset=10000&sort=asc&apikey=${dotenv.env['API_KEY']}");
      var response = await client.get(url);
      return (response.statusCode, response.body);
    } catch (e) {
      debugPrint(e.toString());
      return (-1, null);
    }
  }

  Future getInternalTransactionHistory() async {
    try {
      var url = Uri.parse(
          "$baseUrlEtherScan?module=account&action=txlistinternal&&startblock=0&endblock=99999999&address=$address&page=1&sort=asc&offset=10000&apiKey=${dotenv.env['API_KEY']}");
      var response = await client.get(url);
      return (response.statusCode, response.body);
    } catch (e) {
      debugPrint(e.toString());
      return (-1, null);
    }
  }
}
