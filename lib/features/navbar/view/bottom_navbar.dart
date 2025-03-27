import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import '../../feature.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  final ShoeController shoeController = Get.find<ShoeController>();

  Color? colors, color;
  final List<Widget> _screens = [
    DashboardScreen(),
    ShoeCart(),
    AlertTimer(),
    Center(
      child: Text('data4'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget btn(
    int index, {
    required IconData icon,
    required bool isShow,
    required String text,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _onItemTapped(index),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(
              top: -10,
              end: -1,
            ),
            showBadge: isShow,
            ignorePointer: false,
            onTap: () {},
            badgeContent: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            badgeAnimation: badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 1),
              colorChangeAnimationDuration: Duration(seconds: 1),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.easeInCubic,
            ),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.red,
              padding: EdgeInsets.all(4),
              borderRadius: BorderRadius.circular(4),
              // borderSide: BorderSide(color: Colors.white, width: 2),
              elevation: 0,
            ),
            child: Icon(
              icon,
              size: 28,
              color: color,
            ),
          ),
        ),
        _selectedIndex == index
            ? Container(
                alignment: Alignment.center,
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Scaffold(
            extendBody: true,
            body: _screens[_selectedIndex],
            bottomNavigationBar: Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  btn(0, icon: Icons.home, isShow: false, text: ''),
                  btn(
                    1,
                    icon: Icons.shopify,
                    isShow: controller.cartItems.isNotEmpty,
                    text: controller.totalItems.toString(),
                  ),
                  btn(
                    2,
                    icon: Icons.notifications,
                    isShow: false,
                    text: '',
                  ),
                  btn(3, icon: Icons.person, isShow: false, text: ''),
                ],
              ),
            ),
          );
        });
  }
}

