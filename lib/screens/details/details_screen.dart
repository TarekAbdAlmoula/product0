import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product0/constants.dart';
import 'package:product0/models/Product.dart';
import 'package:product0/screens/details/components/body.dart';
import 'package:product0/screens/home/data/model/prod.dart';

import '../home/components/favIcon.dart';

class DetailsScreen extends StatelessWidget {
  final Prod prod;
  const DetailsScreen({super.key, required this.prod});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(prod: prod),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kMainColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
          height: 25,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        // FavIcon(product: product),
        const SizedBox(width: kDefaultPaddin),
      ],
    );
  }
}
