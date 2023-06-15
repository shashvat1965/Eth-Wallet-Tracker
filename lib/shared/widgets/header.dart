import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding:
            EdgeInsets.only(top: 32.h, bottom: 20.h, left: 24.h, right: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Color(0xffA2ADB3),
                Color(0xffF3F1F2),
                Color(0xffBCC3C9),
                Color(0xffDCDFE4)
              ], stops: [
                0.016,
                0.3599,
                0.662,
                1
              ]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                widget.title,
                style: GoogleFonts.poppins(
                    fontSize: 24.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset('assets/icons/notif.svg',
                    width: 17.w, height: 20.h),
                SizedBox(
                  width: 24.w,
                ),
                SvgPicture.asset(
                  'assets/icons/qrcode.svg',
                  width: 17.w,
                  height: 20.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
