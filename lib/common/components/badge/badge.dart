import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class Badges extends StatelessWidget {
  const Badges({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
    required this.text,
    required this.isShow,
    required this.tap,
  });

  final IconData icon;
  final double size;
  final Color color;
  final String text;
  final bool isShow;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tap(),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(
          top: -10,
          end: -12,
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
          size: size,
          color: color,
        ),
      ),
    );
  }
}
