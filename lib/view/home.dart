import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_ordo_mobile/controller/home.dart';
import 'package:test_ordo_mobile/utils/theme/theme_color.dart';
import 'package:test_ordo_mobile/view/dashboard.dart';
import 'package:test_ordo_mobile/view/screen1.dart';
import 'package:test_ordo_mobile/view/screen2.dart';
import 'package:test_ordo_mobile/view/screen3.dart';
import 'package:test_ordo_mobile/view/screen4.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeCt = Get.put(HomeController());

  List<Widget> _buildScreens() {
    return [
      Screen1(),
      Screen2(),
      DashboardScreen(),
      Screen3(),
      Screen4(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/assignment.svg',
          width: 25,
          height: 25,
          color: _homeCt.tabController.index == 0
              ? ThemeColor.activeIcon
              : ThemeColor.inactiveIcon,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/swap_horiz.svg',
          width: 25,
          height: 25,
          color: _homeCt.tabController.index == 1
              ? ThemeColor.activeIcon
              : ThemeColor.inactiveIcon,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/home_alt_fill.svg',
          width: 25,
          height: 25,
          color: _homeCt.tabController.index == 2
              ? ThemeColor.activeIcon
              : ThemeColor.inactiveIcon,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/assessment.svg',
          width: 25,
          height: 25,
          color: _homeCt.tabController.index == 3
              ? ThemeColor.activeIcon
              : ThemeColor.inactiveIcon,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/person.svg',
          width: 25,
          height: 25,
          color: _homeCt.tabController.index == 4
              ? ThemeColor.activeIcon
              : ThemeColor.inactiveIcon,
        ),
      ),
    ];
  }

  @override
  void initState() {
    _homeCt.page.listen((page) {
      _homeCt.tabController.index = page;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          controller: _homeCt.tabController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          backgroundColor: Colors.white,
          onItemSelected: (index) => _homeCt.page(index),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.simple,
        ),
      ),
    );
  }
}
