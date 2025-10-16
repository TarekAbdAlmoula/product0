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
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 242, 242, 242),
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
            style: TextStyle(
              fontSize: 17,
              color: const Color.fromARGB(255, 140, 140, 140),
            ),
          ),
        ],
      ),
    );
  }
}
