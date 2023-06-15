import 'package:cypherock_task/history/ui/history_page.dart';
import 'package:cypherock_task/non_developed_page/non_dev_page.dart';
import 'package:cypherock_task/portfolio/ui/portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const Portfolio(),
      const History(),
      const NonDevPage(),
      const NonDevPage(),
      const NonDevPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/navbar_icons/portfolio_active.svg"),
        inactiveIcon: SvgPicture.asset("assets/navbar_icons/portfolio.svg"),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/navbar_icons/history_active.svg"),
        inactiveIcon: SvgPicture.asset("assets/navbar_icons/history.svg"),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/navbar_icons/receive_active.svg"),
        inactiveIcon: SvgPicture.asset("assets/navbar_icons/receive.svg"),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/navbar_icons/learn_active.svg"),
        inactiveIcon: SvgPicture.asset("assets/navbar_icons/learn.svg"),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/navbar_icons/setting_active.svg"),
        inactiveIcon: SvgPicture.asset("assets/navbar_icons/setting.svg"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarHeight: 101.h,
      confineInSafeArea: true,
      backgroundColor: const Color(0xff2C2929),
      stateManagement: true,
      decoration: const NavBarDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff211C18),
        Color(0xff211A16),
        Color(0xff252219)
      ])),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popActionScreens: PopActionScreensType.all,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.linear,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
