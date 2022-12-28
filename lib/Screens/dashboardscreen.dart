/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/screens/cart/cart_screen.dart';
import 'package:sixam_mart/view/screens/favourite/favourite_screen.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/menu/new_menu_screen.dart';
import 'package:sixam_mart/view/screens/order/order_screen.dart';
import 'package:sixam_mart/widgets/curved_nav_bar.dart';

import 'GameScreen.dart';
import 'HomeScreen.dart';
import 'PlayScreen.dart';
import 'ProfileScreen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
 // bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      GameScreen(),
      PlayScreen(),
      // Container(),
      ProfileScreen()
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    */
/*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*//*

  }

  @override
  Widget build(BuildContext context) {
    print('Page Index -- $_pageIndex');
    List<Icon> _naviagtionIcons = [
      Icon(
        Icons.home,
        color: _pageIndex == 0 ? Colors.white : Colors.black,
      ),
      Icon(Icons.favorite_rounded,
          color: _pageIndex == 1 ? Colors.white : Colors.black),
      Icon(Icons.shopping_cart,
          color: _pageIndex == 2 ? Colors.white : Colors.black),
      Icon(Icons.shopping_bag,
          color: _pageIndex == 3 ? Colors.white : Colors.black),
      Icon(Icons.menu, color: _pageIndex == 4 ? Colors.white : Colors.black),
    ];
    return Scaffold(
      key: _scaffoldKey,
      // floatingActionButton: ResponsiveHelper.isDesktop(context)
      //     ? null
      //     : FloatingActionButton(
      //         elevation: 5,
      //         backgroundColor: _pageIndex == 2
      //             ? Color(0xff171E30)
      //             //Theme.of(context).primaryColor
      //             : Theme.of(context).cardColor,
      //         onPressed: () {
      //           _setPage(2);
      //         },
      //         child: CartWidget(
      //             color: _pageIndex == 2
      //                 ? Colors.white

      //                 //Color(0xff171E30)
      //                 //Theme.of(context).cardColor
      //                 : Theme.of(context).disabledColor,
      //             size: 30),
      //       ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
      // BottomAppBar(
      //     elevation: 5,
      //     notchMargin: 5,
      //     clipBehavior: Clip.antiAlias,
      //     shape: CircularNotchedRectangle(),
BottomNavigationBar(items: [

],)
      ,

      // Padding(
      //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      //   child: Row(children: [
      //     BottomNavItem(iconData: Icons.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
      //     BottomNavItem(iconData: Icons.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
      //     Expanded(child: SizedBox()),
      //     BottomNavItem(iconData: Icons.shopping_bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
      //     BottomNavItem(iconData: Icons.menu, isSelected: _pageIndex == 4, onTap: () {
      //       Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
      //     }),
      //   ]),
      // ),

      body: PageView.builder(
        controller: _pageController,
        itemCount: _screens.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _screens[index];
        },
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
*/
