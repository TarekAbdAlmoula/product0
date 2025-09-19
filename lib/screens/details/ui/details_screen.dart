import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/remote/details_remote_source_impl.dart';
import 'package:product0/screens/details/data/repository/details_repository_impl.dart';
import 'package:product0/screens/details/ui/components/custom_button.dart';
import 'package:product0/screens/details/ui/components/details_screen_body.dart';
import 'package:product0/screens/details/ui/viewmodel/details_state.dart';
import 'package:product0/screens/details/ui/viewmodel/details_viewmodel.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';

class DetailsScreen extends StatefulWidget {
  final Workshop workshop;
  const DetailsScreen({super.key, required this.workshop});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int rating = 0;

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
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    final detailsViewmodel = context.read<DetailsViewmodel>();

                    showModalBottomSheet(
                      context: context,
                      builder: (bottomSheetContext) {
                        return BlocProvider.value(
                          value: detailsViewmodel,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: BlocBuilder<DetailsViewmodel, DetailsState>(
                              builder: (context, state) {
                                if (state.uiState == UiState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.uiState == UiState.data) {
                                  return Column(
                                    children: [
                                      Text(
                                        'ما رأيك ب ${widget.workshop.title}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      RatingBar.builder(
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {
                                          setState(() {
                                            rating = value.toInt();
                                          });
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      CustomButton(
                                        onTap: () {
                                          detailsViewmodel.sendRating(rating);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text('يوجد خطأ');
                                }
                              },
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
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
              backgroundColor: kMainColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: DetailsScreenBody(workshop: widget.workshop),
          );
        },
      ),
    );
  }
}
