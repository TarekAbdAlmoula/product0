import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/components/categories_card.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/datasource/home_remote_source_impl.dart';
import 'package:product0/screens/home/ui/viewmode/components/custom_appbar.dart';
import 'package:product0/screens/home/ui/viewmode/home_State.dart';
import 'package:product0/screens/home/ui/viewmode/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

                      Row(
                        spacing: 140,
                        children: [
                          Text('عرض الكل', style: TextStyle(fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              ':الأعلى تقيماً',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      TopRatedCard(),
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

class TopRatedCard extends StatelessWidget {
  const TopRatedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 150,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        // margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage('assets/images/0.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // Text('data', textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Positioned(
                  left: 85,
                  top: 5,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffEF4565),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'غيار زيت',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
