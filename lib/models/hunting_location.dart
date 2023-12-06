// data.dart

import 'dart:math';

class HuntingLocation {
  final List<String> imagePaths;
  final String thumbnail;
  final String tekaTekiTitle;
  final String tekaTekiDescription;
  final List<String> huntingTypes;
  final Map<String, List<String>> rewardInfo;

  HuntingLocation({
    required this.imagePaths,
    required this.thumbnail,
    required this.tekaTekiTitle,
    required this.tekaTekiDescription,
    required this.huntingTypes,
    required this.rewardInfo,
  });
}

List<String> tekaTekiTitles = [
  "Riddle of the Enchanted Forest",
  "Mystery at Moonlight Bay",
  "Secrets of the Lost City",
  "Treasure Hunt in Timeless Tombs",
  "Whispers of Whispering Woods",
  "Puzzles in the Mystic Mountains",
];

List<String> huntingTypes = [
  "Adventure",
  "Discovery",
  "Experience",
  "Challenge"
];

String generateRandomTekaTeki() {
  List<String> tekaTekiOptions = [
    "Beneath the ancient oak, the key lies hidden.",
    "Follow the stars to uncover the path ahead.",
    "Decipher the runes to reveal the ancient secret.",
    "In the shadow of the tallest peak, seek the entrance.",
    "As the river bends, so does destiny unfold.",
    "Where the moonlight touches the earth, the prize awaits.",
  ];

  int randomIndex = Random().nextInt(tekaTekiOptions.length);
  return tekaTekiOptions[randomIndex];
}

HuntingLocation generateRandomHuntingLocation() {
  int numOfImages = 3;
  List<String> randomImagePaths = List.generate(
    numOfImages,
    (index) => "assets/images/hint_${index + 1}.png",
  );

  String randomThumbnail = randomImagePaths.first;
  String randomTekaTekiTitle =
      tekaTekiTitles[Random().nextInt(tekaTekiTitles.length)];
  String randomTekaTekiDescription = generateRandomTekaTeki();

  List<String> randomHuntingTypes = List.generate(
    Random().nextInt(huntingTypes.length) + 1,
    (index) => huntingTypes[index],
  );

  Map<String, List<String>> randomRewardInfo = {
    "Reward Type": ["Exclusive Item", "E-Money", "Surprise"],
    "Redeem Type": ["Hubungi Pengelola", "Submit evidence"],
  };

  return HuntingLocation(
    imagePaths: randomImagePaths,
    thumbnail: randomThumbnail,
    tekaTekiTitle: randomTekaTekiTitle,
    tekaTekiDescription: randomTekaTekiDescription,
    huntingTypes: randomHuntingTypes,
    rewardInfo: randomRewardInfo,
  );
}
