import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata_app/constants.dart';
import 'package:wisata_app/screens/dashboard_screen.dart';
import 'package:wisata_app/screens/profile_screen.dart';

enum MenuState { home, message, profile }

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor =
        Colors.white; // Set the inActiveIconColor to white
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.black, // Set the background color to black
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: MenuState.home == selectedMenu
                    ? primaryColor
                    : inActiveIconColor,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/message.svg",
                color: inActiveIconColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/account.svg",
                color: MenuState.profile == selectedMenu
                    ? primaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
