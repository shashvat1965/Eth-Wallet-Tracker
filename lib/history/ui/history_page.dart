import 'package:cypherock_task/history/history_view_model.dart';
import 'package:cypherock_task/history/ui/history_list.dart';
import 'package:cypherock_task/history/ui/time_amount_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/header.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    initHistory();
    super.initState();
  }

  initHistory() async {
    await HistoryViewModel().getTransactionList();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          isLoading.value = true;
          initHistory();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 1.sh - 101.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff211C18),
              Color(0xff211A16),
              Color(0xff252219)
            ])),
            child: Column(
              children: [
                const Header(title: "History"),
                const TimeAmountRow(),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool value, child) {
                      if (value) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          ),
                        );
                      } else {
                        if (HistoryViewModel.hasError) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline_outlined,
                                  size: 40.r,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Text(
                                  HistoryViewModel.errorMessage,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18.sp),
                                )
                              ],
                            ),
                          );
                        } else {
                          return HistoryList();
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
