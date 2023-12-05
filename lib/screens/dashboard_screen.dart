import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata_app/screens/main_screen.dart';
import 'package:wisata_app/utils/contants.dart';
import 'package:wisata_app/widgets/button_nav_bar.dart';
import 'package:wisata_app/widgets/category_card.dart';
import 'package:wisata_app/widgets/lokasi_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const ButtonNavBar(selectedMenu: MenuState.home),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-dashboard.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .03),
                  LokasiCard(),
                  SizedBox(height: size.height * .03),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Vacation",
                          imgSrc: "assets/icons/vacation.png",
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }));
                          },
                        ),
                        CategoryCard(
                          title: "News",
                          imgSrc: "assets/icons/news.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Ticket",
                          imgSrc: "assets/icons/ticket.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Lodging",
                          imgSrc: "assets/icons/lodging.png",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
