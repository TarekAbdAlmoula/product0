import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/ui/details_screen.dart';
import 'package:product0/screens/home/ui/components/categories_card.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/data/datasource/home_remote_source_impl.dart';
import 'package:product0/screens/home/ui/components/custom_appbar.dart';
import 'package:product0/screens/home/ui/components/home_workshop_card.dart';
import 'package:product0/screens/home/ui/components/showMore_screen.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(
        homeRepositoryImpl: HomeRepositoryImpl(
          homeRemoteSourceImpl: HomeRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            if (state.uiState == UiState.loading) {
              return Center(
                child: CircularProgressIndicator(color: kMainColor),
              );
            } else if (state.uiState == UiState.data) {
              PageController pageController = changeImage(state);

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomAppBar(),
                      SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: state.adds.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(state.adds[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      CategoriesCard(categories: state.categories),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        child: Row(
                          spacing: 180,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowmoreScreen(
                                      workshop: state.featuredWorkshop,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Text('المميزون', style: TextStyle(fontSize: 25)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          reverse: true,
                          itemCount: state.featuredWorkshop.length > 5
                              ? 5
                              : state.featuredWorkshop.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return HomeWorkshopCard(
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      workshop: state.featuredWorkshop[index],
                                    ),
                                  ),
                                );
                              },
                              workshop: state.featuredWorkshop[index],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        child: Row(
                          spacing: 155,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowmoreScreen(
                                      workshop: state.topRatedWorkshop,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              'الأعلى تقيماً',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      workshop: state.topRatedWorkshop[index],
                                    ),
                                  ),
                                );
                              },
                              workshop: state.topRatedWorkshop[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text('There is an error');
            }
          },
        ),
      ),
    );
  }

  PageController changeImage(HomeState state) {
    PageController _pageController = PageController(
      initialPage: state.currentBannerIndex,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          state.currentBannerIndex,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    });
    return _pageController;
  }
}
