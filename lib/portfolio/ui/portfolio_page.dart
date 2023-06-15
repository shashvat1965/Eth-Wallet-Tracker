import 'package:cypherock_task/portfolio/portfolio_view_model.dart';
import 'package:cypherock_task/portfolio/ui/assets_amounts_row.dart';
import 'package:cypherock_task/portfolio/ui/eth_row.dart';
import 'package:cypherock_task/shared/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1.0, 0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  @override
  void initState() {
    initValuesForBalance();
    super.initState();
  }

  initValuesForBalance() async {
    await PortfolioViewModel().calculateBalance();
    _controller.reset();
    _controller.forward();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xff2C2929),
            gradient: LinearGradient(colors: [
              Color(0xff211C18),
              Color(0xff211A16),
              Color(0xff252219)
            ])),
        child: Column(
          children: [
            const Header(title: "Portfolio"),
            const AssetsAmountsRow(),
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, bool value, child) {
                  if (!value) {
                    if (PortfolioViewModel.hasError) {
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
                              PortfolioViewModel.errorMessage,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SlideTransition(
                        position: _offsetAnimation,
                        child: EthRow(
                          balanceETH: PortfolioViewModel.balanceETH,
                          balanceUSD: PortfolioViewModel.balanceUSD,
                        ),
                      );
                    }
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
