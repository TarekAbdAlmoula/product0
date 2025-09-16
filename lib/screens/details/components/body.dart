import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';

class DetailsScreenBody extends StatelessWidget {
  final Workshop workshop;
  const DetailsScreenBody({super.key, required this.workshop});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Hero(
              tag: "hero_${workshop.code}",
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(workshop.featuredImageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            Row(
              // spacing: ,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID:${workshop.code}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  textAlign: TextAlign.end,
                  workshop.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              workshop.content,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      Text(
                        workshop.phoneNumner,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class productInfo extends StatelessWidget {
  const productInfo({super.key, required this.product, required this.title});

  final String product;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xFF8B2833))),
        Text(
          product,
          style: TextStyle(color: Color(0xFF8B2833).withOpacity(0.5)),
        ),
      ],
    );
  }
}
