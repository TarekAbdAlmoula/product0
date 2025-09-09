import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        borderRadius: BorderRadius.circular(10),
        // radius: 200,
        onTap: onTap,
        child: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                SizedBox(width: 5),
                FaIcon(icon, color: color, size: 18),
                // Image.asset(imagePath, height: 30, width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
