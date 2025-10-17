import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/animated_border_circle.dart';
import 'package:product0/core/utils/constants.dart';
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
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(body: LoginScreenBody(), backgroundColor: kMainColor),
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
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Initializes the state of the widget. This function is called
  /// when this widget is inserted into the tree. It overrides the
  /// didChangeDependencies method from the State class.
  /*******  144c82d1-f1ec-48c9-bcfb-f8354291bc25  *******/
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewmodel, AuthState>(
      listener: (context, state) {
        if (state.isLoggedIn == true) {
          context.goNamed(AppRouteConstants.home);
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
                    hintText: 'البريد الالكتروني مثل jHwFV@gmail.com',
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
                      color: kMainColor,
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
                                'جاري تسجيل الدخول',
                                style: TextStyle(
                                  color: kMainDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
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
                        BlocProvider.of<AuthViewmodel>(
                          context,
                        ).login(emailController.text, passwordController.text);
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
