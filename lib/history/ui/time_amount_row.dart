import 'package:cypherock_task/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeAmountRow extends StatelessWidget {
  const TimeAmountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 34, 29, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, -6),
                spreadRadius: 5,
                color: Colors.black.withOpacity(0.2))
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 245,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 16.h),
                  child: Text(
                    "Time",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: const Color(0xff8B8682)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: GestureDetector(
                      onTap: () {
                        HistoryViewModel.timeSortChanged =
                            !HistoryViewModel.timeSortChanged;
                        HistoryViewModel.amountFilterOrSortChanged.value =
                            !HistoryViewModel.amountFilterOrSortChanged.value;
                      },
                      child: SvgPicture.asset(
                          'assets/icons/double_sided_arrow.svg')),
                )
              ],
            ),
          ),
          Expanded(
            flex: 185,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: SizedBox(
                    width: 0.2.sw,
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                        HistoryViewModel().filterTransactionByValue(
                            double.tryParse(value) ?? 0);
                        HistoryViewModel.amountFilterOrSortChanged.value =
                            !HistoryViewModel.amountFilterOrSortChanged.value;
                      },
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: const Color(0xff8B8682)),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 16.sp, color: const Color(0xff8B8682)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: SvgPicture.asset('assets/icons/arrow_up.svg'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
