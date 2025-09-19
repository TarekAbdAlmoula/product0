import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/details/ui/components/details_card.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';
import 'package:url_launcher/url_launcher.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'ID:${workshop.code}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.015,
                          ),
                          child: SvgPicture.asset(
                            height: 15,
                            'assets/icons/Star.svg',
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          '${((workshop.rating / 5) * 100).toString().substring(0, 4)}%',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.end,
                  workshop.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff094067),
                  ),
                ),
              ],
            ),
            DetailsCard(content: workshop.content, title: ': الوصف'),
            DetailsCard(
              content: workshop.phoneNumner,
              title: 'معلومات الاتصال',
            ),
            DetailsCard(
              content: workshop.location.isNotEmpty
                  ? workshop.location
                  : 'لايوجد',
              title: ': منطقة الخدمة',
            ),

            GestureDetector(
              onTap: () async {
                final String phoneNumber = workshop.phoneNumner;
                final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
                await launchUrl(launchUri);
              },
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'اتصال',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
