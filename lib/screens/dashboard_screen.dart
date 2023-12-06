// dashboard.dart

import 'package:flutter/material.dart';
import 'package:wisata_app/models/hunting_location.dart';
import 'package:wisata_app/screens/detail_lokasi.dart';
import 'package:wisata_app/screens/main_screen.dart';
import 'package:wisata_app/widgets/bottom_nav_bar.dart';
import 'package:wisata_app/widgets/hunting_location_card.dart';
import 'package:wisata_app/widgets/lokasi_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Use the data from the imported file
    List<HuntingLocation> dummyHuntingLocations =
        List.generate(6, (index) => generateRandomHuntingLocation());

    var size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.home),
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
                  SizedBox(height: size.height * .04),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Text(
                      'Lokasi Harta Terdekat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dummyHuntingLocations.length,
                      itemBuilder: (BuildContext context, int index) {
                        HuntingLocation location = dummyHuntingLocations[index];
                        List<String> rewardTypes =
                            location.rewardInfo['Reward Type'] ?? [];
                        return HuntingLocationCard(
                          title: location.tekaTekiTitle,
                          description: location.tekaTekiDescription,
                          thumbnailPath: location.thumbnail,
                          rewardTypes: rewardTypes,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailLokasi(location: location);
                              }),
                            );
                          },
                        );
                      },
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
