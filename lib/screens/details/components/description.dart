import 'package:flutter/material.dart';
import 'package:product0/screens/home/data/model/prod.dart';

import '../../../core/utils/constants.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.prod});
  final Prod prod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "About",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: kDefaultPaddin / 5),
        Text(
          removeHtmlTags(prod.shortDesc),
          style: const TextStyle(height: 1.5, color: Colors.black),
        ),
      ],
    );
  }
}

String removeHtmlTags(String htmlString) {
  RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}
