import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('مرحبا بك', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 5),
                        Image.asset('assets/images/hello_icon.png', height: 20),
                      ],
                    ),
                    Text('عبد الله', style: TextStyle(fontSize: 25)),
                  ],
                ),
                Spacer(flex: 2),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_on,
                    color: Color(0xff3da9fc),
                    size: 30,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                hintText: 'بحث ...',
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
