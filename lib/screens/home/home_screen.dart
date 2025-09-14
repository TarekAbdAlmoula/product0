import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/components/categorries_card.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/datasource/home_remote_source_impl.dart';
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
              return Center(child: CircularProgressIndicator());
            } else if (state.uiState == UiState.data) {
              PageController _pageController = changeImage(state);

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: CustomAppBar(),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: PageView.builder(
                          controller: _pageController,
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
                      // ToggleSwitch(labels: ['csdc', 'vewevwv']),
                      // ToggleButtons(children: , isSelected: isSelected),
                      // Body(prod: state.prod, categories: state.categories),
                      // UpperBody(),
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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('مرحبا بك', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 5),
                      Image.asset('assets/images/hello_icon.png', height: 20),
                    ],
                  ),
                  Text('عبد الله', style: TextStyle(fontSize: 25)),
                ],
              ),
              Spacer(flex: 2),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_on,
                  color: Color(0xff3da9fc),
                  size: 30,
                ),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              hintText: 'بحث ...',
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
