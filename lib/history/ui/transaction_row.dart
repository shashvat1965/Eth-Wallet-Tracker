import 'dart:math';

import 'package:cypherock_task/history/history_data_models.dart';
import 'package:cypherock_task/history/history_view_model.dart';
import 'package:cypherock_task/input_screen/input_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionRow extends StatefulWidget {
  TransactionRow({super.key, required this.transaction, required this.isOdd});
  Transaction transaction;
  bool isOdd;
  @override
  State<TransactionRow> createState() => _TransactionRowState();
}

class _TransactionRowState extends State<TransactionRow> {
  String formatTimestampToTime(String timestamp) {
    //getting 12 hour time from timestamp
    int timestampInInt = int.parse(timestamp);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestampInInt * 1000);
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour < 12 ? 'AM' : 'PM';
    hour = hour % 12;
    hour = hour != 0 ? hour : 12;
    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }

  calculateEthSpent(String price, String gasUsed) {
    BigInt priceInt = BigInt.parse(price);
    BigInt gasUsedInt = BigInt.parse(gasUsed);
    double total = (priceInt + gasUsedInt) / BigInt.from(pow(10, 18));
    return double.parse(total.toStringAsFixed(2));
  }

  calculateUsdSpent(double ethSpent) {
    return (ethSpent * InputScreenViewModel.conversionFactor)
        .toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    bool isSent = HistoryViewModel().isEthSent(widget.transaction);
    return Container(
      decoration: widget.isOdd
          ? const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff16120F), Color(0xff1F1915)]))
          : const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 16.h),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/${isSent ? "sent.svg" : "received.svg"}'),
                SizedBox(
                  width: 24.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSent ? "Sent" : "Received",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                    Text(
                      formatTimestampToTime(widget.transaction.timeStamp!),
                      style: GoogleFonts.poppins(
                          color: const Color(0xff8B8682), fontSize: 14.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/eth-2.svg'),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "${calculateEthSpent(widget.transaction.value!, widget.transaction.gasUsed!)} ETH",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                        'assets/icons/${isSent ? "minus.svg" : "plus.svg"}'),
                    SizedBox(
                      width: 8.h,
                    ),
                    Text(
                      "\$ ${calculateUsdSpent(calculateEthSpent(widget.transaction.value!, widget.transaction.gasUsed!))}",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff8B8682), fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
