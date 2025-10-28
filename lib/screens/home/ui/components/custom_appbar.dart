import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String userName;
  final String userPoints;
  final void Function(String)? onSubmitted;
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.userPoints,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRouteConstants.search);
                        },
                        child: Text(
                          'مرحبا بك',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kMainDarkColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Image.asset('assets/images/hello_icon.png', height: 20),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,

                    child: Text(
                      userName,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kMainDarkColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(flex: 20),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Text(
                  textAlign: TextAlign.start,
                  userPoints,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                    fontSize: 28,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.all(0),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(children: [Text('نقاطي')]),
                        ),
                      );
                    },
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/gift.svg',
                  height: 25,
                  width: 25,
                  color: kMainDarkColor,
                ),
              ),
              Spacer(),
            ],
          ),
          TextField(
            cursorColor: kMainColor,
            onSubmitted: onSubmitted,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'بحث ...',
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: Colors.grey, size: 30),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        ],
      ),
    );
  }
}
