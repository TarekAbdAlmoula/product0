import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/workshops/ui/workshop_card.dart';

class ShowmoreScreen extends StatelessWidget {
  final List<Workshop> workshop;
  const ShowmoreScreen({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kMainDarkColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),

        itemCount: workshop.length,
        itemBuilder: (context, index) {
          return WorkshopCard(
            press: () {
              context.pushNamed(
                AppRouteConstants.details,
                extra: workshop[index],
              );
            },
            workshop: workshop[index],
          );
        },
      ),
    );
  }
}
