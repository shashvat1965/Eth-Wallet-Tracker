import 'dart:convert';
import 'dart:math';
import 'package:cypherock_task/api/api_calls.dart';
import 'package:cypherock_task/history/history_data_models.dart';
import 'package:flutter/cupertino.dart';

class HistoryViewModel {
  static bool timeSortChanged = true;
  static ValueNotifier<bool> amountFilterOrSortChanged = ValueNotifier(true);
  static bool hasError = false;
  static String errorMessage = "";
  static List<Transaction> transactionHistory = [];
  static Map<String, List<Transaction>> sortedTransactions = {};
  static Map<String, List<Transaction>> sortedFilteredTransactions = {};

  Future<void> getTransactionList() async {
    sortedFilteredTransactions.clear();
    sortedTransactions.clear();
    transactionHistory.clear();
    int? statusCode;
    String? jsonResponseString;

    //getting normal txn
    (statusCode, jsonResponseString) =
        await ApiCalls().getNormalTransactionHistory();
    if (statusCode == 200) {
      if (jsonDecode(jsonResponseString!)['status'] == "1") {
        // getting a List<Transaction> from the response
        transactionHistory = getTransactionListFromJson(jsonResponseString);
        sortTransactionsByDate(transactionHistory);
      } else {
        hasError = true;
        errorMessage = jsonDecode(jsonResponseString)['result'];
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

  List<Transaction> getTransactionListFromJson(String jsonResponseString) {
    List<Transaction> transactionList = [];
    var decodedJson = jsonDecode(jsonResponseString);
    if (decodedJson['result'] != null) {
      decodedJson['result'].forEach((v) {
        transactionList.add(Transaction.fromJson(v));
      });
    }
    return transactionList;
  }

  void sortTransactionsByDate(List<Transaction> transactions) {
    // Sort transactions by date
    transactions.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));

    for (var transaction in transactions) {
      // Convert the timestamp to DateTime
      int timestamp = int.parse(transaction.timeStamp!);
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

      // Format the date as yyyy-MM-dd
      String formattedDate = getFormattedDate(timestamp.toString());

      // Add the transaction to the corresponding date
      if (sortedTransactions.containsKey(formattedDate)) {
        sortedTransactions[formattedDate]!.add(transaction);
      } else {
        sortedTransactions[formattedDate] = [transaction];
      }
    }

    // solution for implementing deep copying i.e copying with values rather than reference
    sortedFilteredTransactions.clear();
    for (String date in sortedTransactions.keys) {
      List<Transaction> transactionList = [];
      for (Transaction transaction in sortedTransactions[date] ?? []) {
        transactionList.add(Transaction(
            timeStamp: transaction.timeStamp,
            to: transaction.to,
            gasUsed: transaction.gasUsed,
            value: transaction.value,
            from: transaction.from));
      }
      print(transactionList);
      sortedFilteredTransactions[date] = transactionList;
    }
  }

  void filterTransactionByValue(double? amount) {
    // solution for implementing deep copying i.e copying with values rather than reference
    sortedFilteredTransactions.clear();
    for (String date in sortedTransactions.keys) {
      List<Transaction> transactionList = [];
      for (Transaction transaction in sortedTransactions[date] ?? []) {
        transactionList.add(Transaction(
            timeStamp: transaction.timeStamp,
            to: transaction.to,
            gasUsed: transaction.gasUsed,
            value: transaction.value,
            from: transaction.from));
      }
      sortedFilteredTransactions[date] = transactionList;
    }

    if ((amount ?? 0) > 0) {
      for (String date in sortedFilteredTransactions.keys) {
        (sortedFilteredTransactions[date] ?? []).removeWhere((value) =>
            (double.parse(((BigInt.parse(value.value!) +
                            BigInt.parse(value.gasUsed!)) /
                        BigInt.from(pow(10, 18)))
                    .toStringAsFixed(2)) <
                (amount ?? 0.0)));
      }
    }
    sortedFilteredTransactions.removeWhere(
        (key, value) => (sortedFilteredTransactions[key]!.isEmpty));
  }

  String getFormattedDate(String timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    List<String> weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String day = weekdays[dateTime.weekday - 1];
    String month = months[dateTime.month - 1];
    String year = dateTime.year.toString();
    String formattedDate = '$day, $month ${dateTime.day}, $year';

    return formattedDate;
  }

  bool isEthSent(Transaction transaction) {
    String? fromAddress = transaction.from;

    if (fromAddress == '0x73bceb1cd57c711feac4224d062b0f6ff338501e') {
      return true;
    } else {
      return false;
    }
  }
}
