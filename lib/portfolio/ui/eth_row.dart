import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EthRow extends StatefulWidget {
  EthRow({super.key, required this.balanceETH, required this.balanceUSD});
  double balanceETH;
  double balanceUSD;
  @override
  State<EthRow> createState() => _EthRowState();
}

class _EthRowState extends State<EthRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff16120F), Color(0xff1F1915)])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 16.h),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/eth-1.svg'),
                SizedBox(
                  width: 24.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ethereum",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                    Text(
                      "${widget.balanceETH} ETH",
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
                Text(
                  "\$ ${widget.balanceUSD}",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/arrow_down_red.svg'),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "\$ 00.321 | 2.34 %",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff8B8682), fontSize: 14.sp),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
