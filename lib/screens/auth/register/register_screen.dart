import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kMainColor),
      backgroundColor: kMainColor,
      body: RegisterScreenBody(),
    );
  }
}

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gradient_background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'الاسم',
                  hintStyle: TextStyle(color: Colors.white),
                  // fillColor: Colors.white,
                  // filled: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
