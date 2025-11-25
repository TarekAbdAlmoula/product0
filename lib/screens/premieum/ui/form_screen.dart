import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/ui/components/register_button.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source_impl.dart';
import 'package:product0/screens/premieum/data/repository/premieum_repository_impl.dart';
import 'package:product0/screens/premieum/ui/viewmodel/premieum_state.dart';
import 'dart:io';

import 'package:product0/screens/premieum/ui/viewmodel/premieum_viewmodel.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final ImagePicker picker = ImagePicker();
  List<XFile>? images = [];
  String token = '';
  bool isLoading = true;
  Future getToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    token = await storage.read(key: 'token') ?? '';
    isLoading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PremieumViewmodel(
        premieumRepositoryImpl: PremieumRepositoryImpl(
          premieumRemoteSource: PremieumRemoteSourceImpl(
            api: DioConsumer(
              dio: Dio(
                BaseOptions(
                  connectTimeout: const Duration(seconds: 15),
                  sendTimeout: const Duration(seconds: 15),
                  receiveTimeout: const Duration(seconds: 10),
                ),
              ),
            ),
          ),
        ),
      ),
      child: BlocConsumer<PremieumViewmodel, PremieumState>(
        listener: (context, state) {
          if (state.uiState == UiState.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "... جاري إرسال الطلب",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      LinearProgressIndicator(
                        minHeight: 6,
                        color: kMainDarkColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.uiState == UiState.data && state.isFormSent) {
            context.pop();
            AwesomeDialog(
              dismissOnTouchOutside: false,
              dialogBackgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black),
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.bottomSlide,
              body: Text('تم إرسال الطلب بنجاح', textAlign: TextAlign.center),
              btnOkOnPress: () {
                context.pop();
              },
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
        builder: (context, state) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: Text(
                "طلب إضافة إعلان/خدمة",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              centerTitle: true,
              backgroundColor: kMainDarkColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: isLoading
                ? Center(child: CircularProgressIndicator(color: kMainColor))
                : (token == '')
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/userBlock.png',
                          height: 150.h,
                          width: 160.w,
                        ),
                        RegisterButton(),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomFormField(
                              formKey: _formKey,
                              hintText: 'الاسم الرئيسي للإعلان/الخدمة',
                              maxLength: 20,
                              controller: productNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال اسم المنتج';
                                }
                                return null;
                              },
                            ),
                            CustomFormField(
                              formKey: _formKey,

                              hintText: 'الوصف',
                              maxLength: 1000,
                              controller: productDescriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال وصف المنتج';
                                }
                                return null;
                              },
                            ),
                            CustomFormField(
                              formKey: _formKey,

                              hintText: 'الموقع مثل:حمص-الدبلان',
                              maxLength: 20,
                              controller: locationController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال الموقع';
                                }
                                return null;
                              },
                            ),
                            CustomFormField(
                              formKey: _formKey,

                              hintText: 'رقم الهاتف',
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الهاتف';
                                }
                                final regex = RegExp(r'^09\d+$');
                                if (!regex.hasMatch(value)) {
                                  return 'الرقم يجب أن يبدأ بـ 09 ويحتوي على أرقام فقط';
                                }
                                if (value.length != 10) {
                                  return 'الرقم يجب أن يتكون من 10 أرقام';
                                }
                                return null;
                              },
                            ),
                            CustomFormField(
                              formKey: _formKey,

                              hintText: 'السعر(اختياري)',
                              maxLength: 10,
                              controller: priceController,
                              validator: (value) {
                                return null;
                              },
                            ),

                            CustomButton(
                              onTap: BlocProvider.of<PremieumViewmodel>(
                                context,
                              ).pickImages,
                              color: Color(0xffef4565),
                              btnText: 'اختر الصور',
                            ),
                            SizedBox(height: 10.h),
                            Wrap(
                              children: state.images!
                                  .map(
                                    (img) => Image.file(
                                      File(img.path),
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 10.h),
                            GestureDetector(
                              onTap: () async {
                                if (state.images == null ||
                                    state.images!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text("يجب اختيار الصور"),
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  //call upload function

                                  await BlocProvider.of<PremieumViewmodel>(
                                    context,
                                  ).uploadImages(
                                    images: state.images,
                                    token: token,
                                    productName: productNameController.text,
                                    productDescription:
                                        productDescriptionController.text,
                                    location: locationController.text,
                                    phoneNumber: phoneNumberController.text,
                                    price: priceController.text ?? '',
                                  );
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //     content: Directionality(
                                  //       textDirection: TextDirection.rtl,
                                  //       child: Text("تم إرسال الطلب بنجاح"),
                                  //     ),
                                  //   ),
                                  // );
                                }
                              },
                              child: Container(
                                width: 180.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    child: Text(
                                      'إرسال الطلب',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // CustomButton(
                            //   onTap: BlocProvider.of<PremieumViewmodel>(
                            //     context,
                            //   ).uploadImages(
                            //     images: state.images,
                            //     token: token,
                            //     productName: productNameController.text,
                            //     productDescription:
                            //         productDescriptionController.text,
                            //     location: locationController.text,
                            //     phoneNumber: phoneNumberController.text,
                            //     price: priceController.text,
                            //   ),
                            //   color: Colors.green,
                            //   btnText: 'إرسال الطلب',
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String hintText;
  final int maxLength;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.maxLength,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.formKey,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: TextFormField(
          minLines: 1,
          maxLines: null,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: Colors.black,
          maxLength: maxLength,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,

              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}
