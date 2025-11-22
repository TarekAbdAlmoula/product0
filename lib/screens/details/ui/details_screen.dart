import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/remote/details_remote_source_impl.dart';
import 'package:product0/screens/details/data/repository/details_repository_impl.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/screens/details/ui/components/details_screen_body.dart';
import 'package:product0/screens/details/ui/viewmodel/details_state.dart';
import 'package:product0/screens/details/ui/viewmodel/details_viewmodel.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/ui/components/register_button.dart';

class DetailsScreen extends StatefulWidget {
  final Workshop workshop;
  const DetailsScreen({super.key, required this.workshop});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  num rating = 0;
  final TextEditingController ratingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsViewmodel(
        detailsRepositoryImpl: DetailsRepositoryImpl(
          detailsRemoteSourceImpl: DetailsRemoteSourceImpl(
            api: DioConsumer(
              dio: Dio(
                BaseOptions(
                  connectTimeout: const Duration(seconds: 8),
                  sendTimeout: const Duration(seconds: 8),
                  receiveTimeout: const Duration(seconds: 8),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                BlocConsumer<DetailsViewmodel, DetailsState>(
                  listener: (context, state) {
                    if (state.uiState == UiState.loading) {
                      AwesomeDialog(
                        dismissOnTouchOutside: false,
                        context: context,
                        title: '...جاري التقييم ',
                        dialogType: DialogType.noHeader,
                      ).show();
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        final detailsViewmodel = context
                            .read<DetailsViewmodel>();

                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (bottomSheetContext) {
                            return BlocProvider.value(
                              value: detailsViewmodel,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(
                                    bottomSheetContext,
                                  ).viewInsets.bottom,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  height: 200.h,
                                  child: BlocConsumer<DetailsViewmodel, DetailsState>(
                                    listener: (context, state) {
                                      if (state.uiState == UiState.data &&
                                          state.ratingModel!.success == true) {
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,

                                          context: bottomSheetContext,
                                          btnOkText: 'حسناً',
                                          dialogType: DialogType.success,
                                          btnOkOnPress: () {
                                            context.pop();
                                            Navigator.pop(bottomSheetContext);
                                            ratingController.clear();
                                          },
                                          body: Html(
                                            data: state.ratingModel!.message,
                                          ),
                                        ).show();
                                      } else if (state.uiState ==
                                              UiState.data &&
                                          state.ratingModel!.success == false) {
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,

                                          context: bottomSheetContext,
                                          btnOkText: 'حسناً',
                                          body: Html(
                                            data: state.ratingModel!.message,
                                          ),
                                          dialogType: DialogType.error,
                                          btnOkOnPress: () {
                                            context.pop();
                                            Navigator.pop(bottomSheetContext);
                                            ratingController.clear();
                                          },
                                        ).show();
                                      } else if (state.uiState ==
                                          UiState.error) {
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,

                                          context: context,
                                          btnOkText: 'حسناً',
                                          body: Text(
                                            state.erroemessage ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                          dialogType: DialogType.error,
                                          btnOkOnPress: () {
                                            context.pop();
                                          },
                                        ).show();
                                      }
                                    },
                                    builder: (context, state) {
                                      return (state.token == '' ||
                                              state.token == null)
                                          ? SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/userBlock.png',
                                                    height: 100.h,
                                                    width: 150.w,
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  RegisterButton(),
                                                ],
                                              ),
                                            )
                                          : Form(
                                              key: _formKey,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'ما رأيك ب ${widget.workshop.title}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    RatingBar.builder(
                                                      itemBuilder:
                                                          (
                                                            context,
                                                            index,
                                                          ) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      onRatingUpdate: (value) {
                                                        rating = value.toInt();
                                                      },
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: TextField(
                                                        cursorColor: kMainColor,
                                                        controller:
                                                            ratingController,
                                                        maxLength: 50,

                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide:
                                                                const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1.5,
                                                                ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            borderSide:
                                                                const BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 2,
                                                                ),
                                                          ),
                                                          hintText:
                                                              'اكتب تقيمك(اختياري)',
                                                        ),
                                                      ),
                                                    ),

                                                    CustomButton(
                                                      btnText: 'إرسال ',

                                                      color: kMainColor,
                                                      onTap: () async {
                                                        await detailsViewmodel
                                                            .sendRating(
                                                              rating,
                                                              widget
                                                                  .workshop
                                                                  .id,
                                                              comment:
                                                                  ratingController
                                                                      .text,
                                                            );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Visibility(
                          visible:
                              widget.workshop.servicesCategory[0] ==
                                      "بيع وإيجار" ||
                                  widget.workshop.servicesCategory[0] ==
                                      "العقارات"
                              ? false
                              : true,
                          child: SvgPicture.asset(
                            'assets/icons/Star.svg',
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              Colors.amber,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              backgroundColor: kMainDarkColor,
              iconTheme: IconThemeData(color: Colors.white, size: 25.h),
            ),
            body: DetailsScreenBody(workshop: widget.workshop),
          );
        },
      ),
    );
  }
}
