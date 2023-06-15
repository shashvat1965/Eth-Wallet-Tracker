import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetsAmountsRow extends StatelessWidget {
  const AssetsAmountsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(39, 34, 29, 1)),
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
                    "Asset",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: const Color(0xff8B8682)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child:
                      SvgPicture.asset('assets/icons/double_sided_arrow.svg'),
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
                  child: Text(
                    "Amount",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: const Color(0xff8B8682)),
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
