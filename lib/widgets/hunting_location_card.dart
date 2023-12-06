// hunting_location_card.dart

import 'package:flutter/material.dart';

class HuntingLocationCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailPath;
  final List<String> rewardTypes;
  final VoidCallback onTap;

  HuntingLocationCard({
    required this.title,
    required this.description,
    required this.thumbnailPath,
    required this.rewardTypes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String truncatedDescription = description.length > 50
        ? '${description.substring(0, 20)}...'
        : description;

    String simplifiedRewardType = rewardTypes.isNotEmpty
        ? 'Reward Type: ${rewardTypes.first}${rewardTypes.length > 1 ? ' and ${rewardTypes.length - 1} more' : ''}'
        : 'No Reward Type';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black.withOpacity(0.7),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: Image.asset(
                thumbnailPath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  truncatedDescription,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  simplifiedRewardType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
