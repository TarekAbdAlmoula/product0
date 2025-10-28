import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/animated_border_circle.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/auth/data/datasource/local/auth_local_source_impl.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source_impl.dart';
import 'package:product0/screens/auth/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';
import 'package:product0/core/components/custom_button.dart';

class OtpScreen extends StatelessWidget {
  final String userId;
  const OtpScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthViewmodel(
        authRepositoryImp: AuthRepositoryImpl(
          authLocalSourceImpl: AuthLocalSourceImpl(),
          authRemoteSourceImpl: AuthRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: kMainDarkColor,
        resizeToAvoidBottomInset: true,
        body: OtpScreenBody(userId: userId),
      ),
    );
  }
}

class OtpScreenBody extends StatefulWidget {
  final String userId;
  const OtpScreenBody({super.key, required this.userId});

  @override
  State<OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<OtpScreenBody> {
  String otp = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewmodel, AuthState>(
      listener: (context, state) {
        if (state.authResponse!.isSuccess == true) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            body: Html(data: state.pointsMessage),
            btnOkText: 'حسناً',
            btnOkOnPress: () {
              context.goNamed(AppRouteConstants.home);
            },
          ).show();
        } else if (state.authResponse!.isSuccess == false) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'خطأ',
            body: Html(data: state.authResponse!.message),
            btnOkText: 'حسناً',
            btnOkOnPress: () {
              context.goNamed(AppRouteConstants.register);
            },
          ).show();
        }
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/gradient_background.png"),
            fit: BoxFit.fill,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AnimatedBorderCircle(),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'تم إرسال رمز التحقق  إلى الايميل ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'أدخل الرمز ',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Form(
                      key: _formKey,

                      child: PinCodeTextField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "الرجاء إدخال الكود";
                        //   } else if (value.length < 6) {
                        //     return "الكود يجب أن يحتوي على6 أرقام";
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.number,
                        textStyle: TextStyle(color: Colors.white),
                        pinTheme: PinTheme(
                          inactiveColor: Colors.white,
                          disabledColor: Colors.amber,
                          selectedColor: kMainColor,
                          // activeColor: kMainDarkColor,
                          fieldOuterPadding: EdgeInsets.all(0),
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 100,
                          fieldWidth: 50,
                          activeFillColor: Colors.white,
                        ),
                        appContext: context,
                        scrollPadding: EdgeInsets.all(1),
                        length: 6,
                        onCompleted: (value) async {
                          otp = value;
                        },
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  btnText: 'إرسال ',

                  color: kMainColor,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // BlocProvider.of<AuthViewmodel>(
                      //   context,
                      // ).verifyOtp(otp: otp, userId: int.parse(widget.userId));

                      AwesomeDialog(
                        // dismissOnTouchOutside: false,
                        dialogBackgroundColor: Colors.white,
                        titleTextStyle: TextStyle(color: Colors.black),
                        context: context,
                        dialogType: DialogType.noHeader,
                        body: Column(
                          children: [
                            Text(
                              'جاري إنشاء حساب جديد',
                              textAlign: TextAlign.center,
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
                                colors: const [kMainDarkColor, kMainColor],
                                strokeWidth: 3,
                                backgroundColor: Colors.white,
                                pathBackgroundColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ).show();
                      await BlocProvider.of<AuthViewmodel>(
                        context,
                      ).verifyOtp(otp: otp, userId: int.parse(widget.userId));

                      // Navigator.pop(context);
                    }

                    // context.goNamed(AppRouteConstants.home);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
