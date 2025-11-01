import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/no_internet_widget.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/data/datasource/local/home_local_source_impl.dart';
import 'package:product0/screens/home/ui/components/categories_card.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/data/datasource/remote/home_remote_source_impl.dart';
import 'package:product0/screens/home/ui/components/custom_appbar.dart';
import 'package:product0/screens/home/ui/components/home_workshop_card.dart';
import 'package:product0/screens/home/ui/viewmodel/home_State.dart';
import 'ui/viewmodel/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(
        homeRepositoryImpl: HomeRepositoryImpl(
          homeLocalSourceImpl: HomeLocalSourceImpl(),
          homeRemoteSourceImpl: HomeRemoteSourceImpl(
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
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 5, backgroundColor: kMainDarkColor),
        backgroundColor: backgroundColor,
        body: BlocConsumer<HomeViewModel, HomeState>(
          listener: (context, state) {
            if (state.uiState == UiState.data && state.pointMessage != '') {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                body: Html(data: state.pointMessage ?? "<p></p>"),
                btnOkText: 'حسناً',
                btnOkOnPress: () {
                  print(state.pointMessage);
                  setState(() {});
                },
              ).show();
            }
          },
          builder: (context, state) {
            if (state.uiState == UiState.loading) {
              return Center(
                child: CircularProgressIndicator(color: kMainColor),
              );
            } else if (state.uiState == UiState.data) {
              return RefreshIndicator(
                color: kMainColor,

                onRefresh: () async {
                  await BlocProvider.of<HomeViewModel>(context).init();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 5,
                      left: 5,
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomAppBar(
                          pointsExpl: state.pointsExpl ?? '',

                          onSubmitted: (query) async {
                            if (query.length > 2) {
                              context.pushNamed(
                                AppRouteConstants.search,
                                pathParameters: {'query': query},
                              );
                            }
                          },
                          userName: state.userName ?? '',
                          userPoints: state.userPoints == null
                              ? ''
                              : state.userPoints.toString(),
                        ),
                        CarouselSlider.builder(
                          itemCount: state.ads!.dataAds.length,
                          itemBuilder: (context, index, realIndex) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: state.ads!.dataAds[index].image,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.lineSpinFadeLoader,
                                    colors: [kMainColor, kMainDarkColor],
                                  ),
                                ),
                                errorWidget: (context, url, error) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'خطأ في تحميل الصورة',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Icon(Icons.error),
                                  ],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        CategoriesCard(categories: state.categories),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRouteConstants.showMore,
                                  extra: state.featuredWorkshop,
                                );
                              },
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'المميزون',
                              style: TextStyle(
                                fontSize: 18,
                                color: kMainDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            reverse: true,
                            // shrinkWrap: true,
                            itemCount: state.featuredWorkshop.length > 5
                                ? 5
                                : state.featuredWorkshop.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Center(
                                child: HomeWorkshopCard(
                                  press: () {
                                    context.pushNamed(
                                      AppRouteConstants.details,
                                      extra: state.featuredWorkshop[index],
                                    );
                                  },
                                  workshop: state.featuredWorkshop[index],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRouteConstants.showMore,
                                  extra: state.topRatedWorkshop,
                                );
                              },
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'ًالأعلى تقييما',
                              style: TextStyle(
                                fontSize: 18,
                                color: kMainDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            reverse: true,

                            itemCount: state.topRatedWorkshop.length > 5
                                ? 5
                                : state.topRatedWorkshop.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return HomeWorkshopCard(
                                press: () {
                                  context.pushNamed(
                                    AppRouteConstants.details,
                                    extra: state.featuredWorkshop[index],
                                  );
                                },
                                workshop: state.topRatedWorkshop[index],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.uiState == UiState.error) {
              return NoInternetWidget(
                errorMessage: state.erroemessage ?? '',
                onTap: () async {
                  await BlocProvider.of<HomeViewModel>(context).init();
                },
              );
            } else {
              return Text('There is an error');
            }
          },
        ),
      ),
    );
  }

  // PageController changeImage(HomeState state) {
  //   PageController _pageController = PageController(
  //     initialPage: state.currentBannerIndex,
  //   );
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (_pageController.hasClients) {
  //       _pageController.animateToPage(
  //         state.currentBannerIndex,
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  //   return _pageController;
  // }
}
