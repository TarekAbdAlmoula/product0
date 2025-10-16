import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';
import 'package:product0/core/components/custom_button.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String text;
  const CustomLoadingDialog({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.text,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onTap: () {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            dialogBackgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            context: context,
            dialogType: DialogType.noHeader,
            body: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: kMainDarkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: const [kMainColor],
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    pathBackgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ).show();
          BlocProvider.of<AuthViewmodel>(
            context,
          ).login(emailController.text, passwordController.text);
        },
      ),
    );
  }
}
