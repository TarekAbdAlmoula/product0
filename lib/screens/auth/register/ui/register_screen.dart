import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/register/data/datasource/local/register_local_source_impl.dart';
import 'package:product0/screens/auth/register/data/datasource/remote/register_remote_Source_impl.dart';
import 'package:product0/screens/auth/register/data/model/user.dart';
import 'package:product0/screens/auth/register/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/components/custom_textfield.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';
import 'package:product0/screens/details/ui/components/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthViewmodel(
        registerRepositoryImp: RegisterRepositoryImpl(
          // registerLocalSourceImpl: RegisterLocalSourceImpl(),
          registerRemoteSourceImpl: RegisterRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(backgroundColor: kMainColor),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewmodel, AuthState>(
      listener: (context, state) {
        final response = state.authResponse;

        if (response != null && response.isSuccess == true) {
          context.goNamed(AppRouteConstants.otp);
        } else if (response != null && response.isSuccess == false) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(response.message)));
        }
      },
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(height: 40),

                  CustomTextField(
                    hintText: 'البريد الالكتروني',
                    controller: emailController,
                    onChanged: (value) => emailController.text = value,
                  ),
                  CustomTextField(
                    hintText: 'كلمة المرور',
                    controller: passwordController,
                    onChanged: (value) => passwordController.text = value,
                  ),
                  CustomTextField(
                    hintText: 'الاسم الاول',
                    controller: firstNameController,
                    onChanged: (value) => firstNameController.text = value,
                  ),
                  CustomTextField(
                    hintText: 'الاسم الاخير',
                    controller: lastNameController,
                    onChanged: (value) => lastNameController.text = value,
                  ),
                  CustomTextField(
                    hintText: 'نوع الحساب',
                    controller: accountType,
                    onChanged: (value) => accountType.text = value,
                  ),
                  CustomTextField(
                    hintText: 'رقم الهاتف',
                    controller: phoneController,
                    onChanged: (value) => phoneController.text = value,
                  ),
                  const SizedBox(height: 20),

                  CustomButton(
                    onTap: () async {
                      final user = User(
                        email: emailController.text,
                        password: passwordController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        userType: accountType.text,
                        phoneNumber: phoneController.text,
                      );

                      await BlocProvider.of<AuthViewmodel>(
                        context,
                      ).createNewUser(user);

                      // context.goNamed(AppRouteConstants.otp);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
