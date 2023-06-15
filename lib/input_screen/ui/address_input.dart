import 'package:cypherock_task/api/api_calls.dart';
import 'package:cypherock_task/input_screen/input_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../navbar.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String inputText = "";
  ValueNotifier<bool> isLoading = ValueNotifier(false);

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
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: Navbar(),
        pageTransitionAnimation: PageTransitionAnimation.slideRight);
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
          child: ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, bool value, child) {
                if (!value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.8.sw,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your wallet address",
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.5)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          style: GoogleFonts.poppins(color: Colors.white),
                          onChanged: (value) {
                            inputText = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 0.1.sh,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            ApiCalls.address = inputText;
                            if (inputText != "") {
                              await handlePress();
                            }
                          },
                          child: const Text("Save Address"))
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                }
              })),
    );
  }
}
