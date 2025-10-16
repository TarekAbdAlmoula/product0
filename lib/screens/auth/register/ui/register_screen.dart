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
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/data/datasource/local/auth_local_source_impl.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source_impl.dart';
import 'package:product0/screens/auth/data/model/user.dart';
import 'package:product0/screens/auth/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/components/custom_textfield.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';
import 'package:product0/core/components/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
        resizeToAvoidBottomInset: true,
        backgroundColor: kMainColor,
        body: RegisterScreenBody(),
      ),
    );
  }
}

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  List<String> userType = ['مستخدم', 'مقدم خدمة'];
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthViewmodel, AuthState>(
      listener: (context, state) {
        final response = state.authResponse;
        if (response != null && response.isSuccess == true) {
          if (mounted) {
            context.goNamed(
              AppRouteConstants.otp,
              pathParameters: {'userId': response.userId.toString()},
            );
          }
        }
      },
      builder: (context, state) {
        if (state.uiState == UiState.data) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/gradient_background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // textAlign: TextAlign.end,
                        'إنشاء حساب',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),

                      AnimatedBorderCircle(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      CustomTextField(
                        hintText: 'الاسم الاول',
                        controller: firstNameController,
                        onChanged: (value) => firstNameController.text = value,
                        formKey: formKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال الاسم";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        hintText: 'الاسم الاخير',
                        controller: lastNameController,
                        onChanged: (value) => lastNameController.text = value,
                        formKey: formKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال الاسم";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        hintText: 'البريد الالكتروني',
                        controller: emailController,
                        onChanged: (value) => emailController.text = value,
                        formKey: formKey,
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
                        formKey: formKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال كلمة المرور";
                          }
                          return null;
                        },
                      ),

                      CustomTextField(
                        hintText: 'رقم الهاتف',
                        controller: phoneController,
                        onChanged: (value) => phoneController.text = value,
                        formKey: formKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال رقم الهاتف";
                          }

                          final phoneRegex = RegExp(r'^[0-9]{8,15}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return "رقم الهاتف غير صالح، الرجاء إدخال أرقام فقط";
                          }

                          return null;
                        },
                        keyBoardType: TextInputType.number,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonFormField<String>(
                          focusColor: Colors.white,
                          hint: Text(
                            'نوع الحساب',
                            style: TextStyle(
                              color: const Color.fromARGB(135, 64, 63, 63),
                            ),
                          ),

                          borderRadius: BorderRadius.circular(20),
                          menuMaxHeight: 120,
                          iconEnabledColor: Colors.white,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),

                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          value: null,
                          items: [
                            for (var i = 0; i < userType.length; i++)
                              DropdownMenuItem(
                                value: userType[i],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          userType[i],
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              135,
                                              64,
                                              63,
                                              63,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            if (value == userType[1]) {
                              accountType.text = 'ورشة';
                            } else if (value == userType[0]) {
                              accountType.text = 'مستخدم';
                            }
                          },
                        ),
                      ),

                      // AccountTypeField(),
                      const SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: CustomButton(
                          onTap: () async {
                            final user = User(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              userType: accountType.text,
                              phoneNumber: phoneController.text,
                            );
                            if (formKey.currentState!.validate()) {
                              AwesomeDialog(
                                // dismissOnTouchOutside: false,
                                dialogBackgroundColor: Colors.white,
                                titleTextStyle: TextStyle(color: Colors.black),
                                context: context,
                                dialogType: DialogType.noHeader,
                                body: Column(
                                  children: [
                                    Text(
                                      'سيتم إرسال رمز التحقق إلى الايميل',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kMainDarkColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.14,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.3,
                                      child: LoadingIndicator(
                                        indicatorType: Indicator.pacman,
                                        colors: const [
                                          kMainDarkColor,
                                          kMainColor,
                                        ],
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
                              ).createNewUser(user);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Text('data');
        }
      },
    );
  }
}
