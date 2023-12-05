import 'package:flutter/material.dart';

class HuntingLocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
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
            width: 50,
            height: 50,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset(
              "assets/images/jalan-asia-afrika.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Judul Lokasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text('deskripsi lokasi / prize',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
