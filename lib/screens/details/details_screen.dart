import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/details/components/body.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';

class DetailsScreen extends StatelessWidget {
  final Workshop workshop;
  const DetailsScreen({super.key, required this.workshop});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: DetailsScreenBody(workshop: workshop),
    );
  }
}
