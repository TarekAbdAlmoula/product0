import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String userName;
  final String userPoints;
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.userPoints,
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
                  GestureDetector(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: 'تهينينا لقد حصت على 50 نقطة',
                        btnOkText: 'حسناً',
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: Row(
                      children: [
                        Text(
                          'مرحبا بك',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kMainDarkColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        Image.asset('assets/images/hello_icon.png', height: 20),
                      ],
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: kMainDarkColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  textAlign: TextAlign.center,
                  userPoints,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                    fontSize: 18,
                  ),
                  // textAlign: TextAlign.start,
                ),
              ),
              // Spacer(flex: 0),
              IconButton(
                // padding: EdgeInsets.all(5),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.all(20),
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
                icon: Icon(Icons.card_giftcard, color: kMainDarkColor),
              ),
              SizedBox(
                // width: ,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Image.asset('assets/images/wasla_logo_wb.png'),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              hintText: 'بحث ...',
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 25),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        ],
      ),
    );
  }
}
