import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NonDevPage extends StatefulWidget {
  const NonDevPage({super.key});

  @override
  State<NonDevPage> createState() => _NonDevPageState();
}

class _NonDevPageState extends State<NonDevPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff211C18),
          Color(0xff211A16),
          Color(0xff252219)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                "Page under development!",
                style: GoogleFonts.poppins(
                    fontSize: 24.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
