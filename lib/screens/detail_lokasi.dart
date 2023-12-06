import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wisata_app/models/hunting_location.dart';
import 'package:wisata_app/widgets/bottom_nav_bar.dart';

class DetailLokasi extends StatelessWidget {
  final HuntingLocation location;

  DetailLokasi({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-dashboard.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: AppBar(
                  title: Text(location.tekaTekiTitle),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      ImageRow(imagePaths: location.imagePaths),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TekaTeki(
                            tekaTekiDescription: location.tekaTekiDescription),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: RewardInfo(
                          huntingTypes: location.huntingTypes,
                          rewardInfo: location.rewardInfo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

class RewardInfo extends StatelessWidget {
  final List<String> huntingTypes;
  final Map<String, List<String>> rewardInfo;

  const RewardInfo({
    Key? key,
    required this.huntingTypes,
    required this.rewardInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldRow("Hunting Type", huntingTypes),
          _buildFieldRow("Reward Type", rewardInfo["Reward Type"] ?? []),
          _buildFieldRow("Redeem Type", rewardInfo["Redeem Type"] ?? []),
        ],
      ),
    );
  }

  Widget _buildFieldRow(String fieldName, List<String> fieldValues) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$fieldName : ",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          for (var value in fieldValues)
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  final List<String> imagePaths;

  ImageRow({required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < imagePaths.length; i++)
            ImageContainer(
              imagePath: imagePaths[i],
              isLast: i == imagePaths.length - 1,
            ),
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final bool isLast;

  ImageContainer({required this.imagePath, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ImageZoomScreen(
                  imagePaths: [imagePath], // Pass a list for a gallery
                  initialIndex: 0,
                );
              }),
            );
          },
          child: Hero(
            tag: imagePath,
            child: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(right: isLast ? 0 : 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                    if (isLast) // Add a centered blue circle for the last image
                      Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageZoomScreen extends StatelessWidget {
  final List<String> imagePaths;
  final int initialIndex;

  ImageZoomScreen({required this.imagePaths, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: imagePaths.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(imagePaths[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.white,
            ),
            pageController: PageController(initialPage: initialIndex),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: AppBar(
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TekaTeki extends StatelessWidget {
  final String tekaTekiDescription;

  TekaTeki({required this.tekaTekiDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Petunjuk Teka Teki",
            style: TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            tekaTekiDescription,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
