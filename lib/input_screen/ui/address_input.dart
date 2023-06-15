import 'dart:ui';

import 'package:cypherock_task/api/api_calls.dart';
import 'package:cypherock_task/input_screen/input_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../navbar.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen>
    with TickerProviderStateMixin {
  String inputText = "";
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool blockTap = false;

  late final AnimationController backgroundRotationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 10000))
        ..repeat();
  late final Animation<double> _rotationAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: backgroundRotationController, curve: Curves.linear));

  late final AnimationController textFieldShakeController = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<Offset> _textFieldOffsetAnimation =
      TweenSequence<Offset>([
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0.125, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0.125, 0.0), end: Offset.zero),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: Offset.zero, end: const Offset(-0.0625, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: const Offset(-0.0625, 0.0), end: Offset.zero),
        weight: 1),
  ]).animate(CurvedAnimation(
    parent: textFieldShakeController,
    curve: Curves.linear,
  ));

  handlePress() async {
    isLoading.value = true;
    await InputScreenViewModel().getConversionFactor();
    if (InputScreenViewModel.hasError) {
      var snackBar = SnackBar(
          content: Text(
            "${InputScreenViewModel.errorMessage}, setting a default value ${InputScreenViewModel.conversionFactor}",
            style: GoogleFonts.poppins(),
          ),
          duration: const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
          width: 1.sw,
          child: Stack(children: [
            ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: RotationTransition(
                    turns: _rotationAnimation,
                    child: SvgPicture.asset(
                      "assets/images/loginBackground.svg",
                      height: 1.sh,
                      width: 1.sw,
                    ))),
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, bool value, child) {
                  if (!value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _textFieldOffsetAnimation,
                            child: SizedBox(
                              width: 0.8.sw,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter your wallet address",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.5)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                style: GoogleFonts.poppins(color: Colors.white),
                                onChanged: (value) {
                                  inputText = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (!blockTap) {
                                  textFieldShakeController.reset();
                                  ApiCalls.address = inputText;
                                  if (inputText != "") {
                                    await handlePress();
                                  } else {
                                    blockTap = true;
                                    textFieldShakeController
                                        .forward()
                                        .then((value) => blockTap = false);
                                  }
                                }
                              },
                              child: const Text("Save Address"))
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                }),
          ])),
    );
  }
}
