import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product0/constants.dart';
import 'package:product0/screens/home/components/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UpperBody extends StatefulWidget {
  const UpperBody({super.key});

  @override
  State<UpperBody> createState() => _UpperBodyState();
}

class _UpperBodyState extends State<UpperBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddin,
          vertical: kDefaultPaddin,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome! Browse our products and discover the best deals today.',
                  style: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  title: 'facebook',
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.blue,
                  onTap: () async {
                    final Uri url = Uri.parse(
                      "https://www.facebook.com/profile.php?id=61579765899608",
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
                CustomButton(
                  title: 'Whatsapp',
                  icon: FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                  onTap: () async {
                    final Uri url = Uri.parse(
                      "https://wa.me/963992915778?text=السلام عليكم",
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.only(right: 10),
            //         child: Container(
            //           height: 35,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.all(Radius.circular(24)),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: TextField(
            //               cursorColor: kTextColor,
            //               onChanged: (value) {},
            //               decoration: InputDecoration(
            //                 hintText: 'Search',
            //                 prefixIcon: SvgPicture.asset(
            //                   "assets/icons/search.svg",
            //                   color: kTextColor,
            //                 ),
            //                 contentPadding: EdgeInsets.symmetric(vertical: 11),
            //                 border: InputBorder.none,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 35,
            //       width: 35,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: SvgPicture.asset(
            //           "assets/icons/filter.svg",
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
