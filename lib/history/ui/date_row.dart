import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DateRow extends StatefulWidget {
  DateRow({super.key, required this.date});
  String date;
  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
          child: Text(
            widget.date,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
