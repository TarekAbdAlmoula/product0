import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/home/ui/components/register_button.dart';

class CustomAppBar extends StatefulWidget {
  final String userName;
  final String userPoints;
  final String pointsExpl;
  final void Function(String)? onSubmitted;
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.userPoints,
    required this.onSubmitted,
    required this.pointsExpl,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _controller = TextEditingController();

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
                        onTap: () {},
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
                      widget.userName,
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
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Text(
                  textAlign: TextAlign.start,
                  widget.userPoints,
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
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 25.h,
                                left: 25.w,
                                right: 25.w,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.white,
                              ),
                              child: Html(data: widget.pointsExpl),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.red,
                                ),
                                margin: EdgeInsets.only(left: 25, right: 25),
                                child: Center(
                                  child: Text(
                                    'إغلاق',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
            controller: _controller,
            cursorColor: kMainColor,
            onSubmitted: widget.onSubmitted,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'بحث ...',
              prefixIcon: IconButton(
                onPressed: () {
                  widget.onSubmitted!(_controller.text);
                },
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

class CustomAppbarWithoutToken extends StatelessWidget {
  final String pointsExpl;
  const CustomAppbarWithoutToken({super.key, required this.pointsExpl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Html(data: pointsExpl),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.red,
                            ),
                            margin: EdgeInsets.only(left: 25, right: 25),
                            child: Center(
                              child: Text(
                                'إغلاق',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SvgPicture.asset(
                'assets/icons/gift.svg',
                height: 25,
                width: 25,
                color: kMainDarkColor,
              ),
            ),
          ),
          Spacer(flex: 1),
          RegisterButton(),
        ],
      ),
    );
  }
}
