import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/animated_border_circle.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/data/datasource/local/auth_local_source_impl.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source_impl.dart';
import 'package:product0/screens/auth/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/components/custom_textfield.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';
import 'package:product0/core/components/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthViewmodel(
        authRepositoryImp: AuthRepositoryImpl(
          authLocalSourceImpl: AuthLocalSourceImpl(),
          authRemoteSourceImpl: AuthRemoteSourceImpl(
            api: DioConsumer(
              dio: Dio(
                BaseOptions(
                  receiveTimeout: const Duration(seconds: 5),
                  sendTimeout: const Duration(seconds: 5),
                  connectTimeout: const Duration(seconds: 5),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Scaffold(resizeToAvoidBottomInset: true, body: LoginScreenBody()),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewmodel, AuthState>(
      listener: (context, state) {
        if (state.isLoggedIn == true) {
          context.goNamed(AppRouteConstants.home);
        } else if (state.authResponse != null &&
            state.authResponse!.isSuccess == false) {
          context.pop();
          AwesomeDialog(
            dialogBackgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            context: context,
            dismissOnTouchOutside: false,

            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            body: Html(data: state.authResponse!.message),
            btnOkOnPress: () {},
            btnOkText: 'حسناً',
          ).show();
        } else if (state.uiState == UiState.error) {
          context.pop();
          AwesomeDialog(
            dismissOnTouchOutside: false,

            dialogBackgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            body: Text(state.erroemessage ?? 'حدث خطأ غير متوقع'),
            btnOkOnPress: () {},
            btnOkText: 'حسناً',
          ).show();
        }
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kMainDarkColor,
          image: DecorationImage(
            image: AssetImage("assets/images/gradient_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                right: 30,
                left: 30,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  AnimatedBorderCircle(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  CustomTextField(
                    onTap: () {
                      emailController.selection = TextSelection.fromPosition(
                        TextPosition(offset: emailController.text.length),
                      );
                    },
                    hintText: 'البريد الالكتروني مثل wasla@gmail.com',
                    controller: emailController,
                    onChanged: (value) => emailController.text = value,
                    formKey: _formKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء إدخال البريد الإلكتروني";
                      }

                      // تحقق بسيط باستخدام regex
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "الرجاء إدخال بريد إلكتروني صالح";
                      }

                      return null;
                    },
                  ),
                  CustomTextField(
                    onTap: () {
                      passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: passwordController.text.length),
                      );
                    },
                    hintText: 'كلمة المرور',
                    controller: passwordController,

                    onChanged: (value) => passwordController.text = value,
                    formKey: _formKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء إدخال كلمة المرور";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: CustomButton(
                      btnText: 'إرسال ',

                      color: kMainColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            dialogBackgroundColor: Colors.white,
                            titleTextStyle: TextStyle(color: Colors.black),
                            context: context,
                            dialogType: DialogType.noHeader,
                            body: Column(
                              children: [
                                Text(
                                  'جاري تسجيل الدخول',
                                  style: TextStyle(
                                    color: kMainDarkColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                  width: 70.w,
                                  child: LoadingIndicator(
                                    indicatorType:
                                        Indicator.ballClipRotatePulse,
                                    colors: const [kMainDarkColor, kMainColor],
                                    strokeWidth: 3.w,

                                    backgroundColor: Colors.white,
                                    pathBackgroundColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ).show();
                          BlocProvider.of<AuthViewmodel>(context).login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextButton(
                    child: Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      context.goNamed(AppRouteConstants.register);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
