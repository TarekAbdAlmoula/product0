import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
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
            api: DioConsumer(dio: Dio()),
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
                GestureDetector(
                  onTap: () {
                    final detailsViewmodel = context.read<DetailsViewmodel>();

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
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: BlocConsumer<DetailsViewmodel, DetailsState>(
                                listener: (context, state) {
                                  if (state.uiState == UiState.data &&
                                      state.ratingModel!.success == true) {
                                    AwesomeDialog(
                                      context: bottomSheetContext,
                                      btnOkText: 'إغلاق',
                                      // title: state.ratingModel!.message,
                                      dialogType: DialogType.success,
                                      btnOkOnPress: () {
                                        Navigator.pop(bottomSheetContext);
                                        ratingController.clear();
                                        context.goNamed(AppRouteConstants.home);
                                      },
                                      body: Html(
                                        data: state.ratingModel!.message,
                                      ),
                                    ).show();
                                  } else if (state.uiState == UiState.data &&
                                      state.ratingModel!.success == false) {
                                    AwesomeDialog(
                                      context: bottomSheetContext,
                                      btnOkText: 'إغلاق',
                                      title: state.ratingModel!.message,
                                      dialogType: DialogType.error,
                                      btnOkOnPress: () {
                                        Navigator.pop(bottomSheetContext);
                                        ratingController.clear();
                                      },
                                      // body: Text('data'),
                                    ).show();
                                  }
                                },
                                builder: (context, state) {
                                  if (state.uiState == UiState.loading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: kMainColor,
                                      ),
                                    );
                                  } else if (state.uiState == UiState.data) {
                                    return Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'ما رأيك ب ${widget.workshop.title}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          RatingBar.builder(
                                            itemBuilder: (context, index) =>
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                            onRatingUpdate: (value) {
                                              rating = value.toInt();
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: TextField(
                                              controller: ratingController,
                                              maxLength: 25,

                                              decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Colors
                                                        .grey, // لون الحافة في الحالة العادية
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Colors
                                                        .green, // لون الحافة عند التركيز
                                                    width: 2,
                                                  ),
                                                ),
                                                hintText: 'اكتب تقيمك(اختياري)',
                                              ),
                                            ),
                                          ),

                                          CustomButton(
                                            btnText: 'إرسال ',

                                            color: kMainColor,
                                            onTap: () async {
                                              await detailsViewmodel.sendRating(
                                                rating,
                                                widget.workshop.id,
                                                comment: ratingController.text,
                                              );
                                            },
                                          ),
                                          // SizedBox(height: 150),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Text('يوجد خطأ');
                                  }
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
                    child: SvgPicture.asset(
                      'assets/icons/Star.svg',
                      height: 20,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
              backgroundColor: kMainDarkColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: DetailsScreenBody(workshop: widget.workshop),
          );
        },
      ),
    );
  }
}
