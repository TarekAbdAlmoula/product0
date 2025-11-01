import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.content, required this.title});
  final String content;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffA3A3A3)),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffF8F8F8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: kMainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
          Divider(color: Colors.grey),
          Text(
            content,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 17, color: Color(0xff5C5C5C)),
          ),
        ],
      ),
    );
  }
}
