import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/no_internet_widget.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/ui/details_screen.dart';
import 'package:product0/screens/home/data/datasource/local/home_local_source_impl.dart';
import 'package:product0/screens/home/data/datasource/remote/home_remote_source_impl.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmodel/home_State.dart';
import 'package:product0/screens/home/ui/viewmodel/home_viewmodel.dart';
import 'package:product0/screens/workshops/ui/workshop_card.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(
        runInit: false,
        homeRepositoryImpl: HomeRepositoryImpl(
          homeLocalSourceImpl: HomeLocalSourceImpl(),
          homeRemoteSourceImpl: HomeRemoteSourceImpl(
            api: DioConsumer(
              dio: Dio(
                BaseOptions(
                  connectTimeout: const Duration(seconds: 1),
                  sendTimeout: const Duration(seconds: 1),
                  receiveTimeout: const Duration(seconds: 1),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: kMainDarkColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Text('البحث', style: TextStyle(color: Colors.white)),
          ),
          centerTitle: true,
        ),
        body: SearchScreenBody(query: query),
      ),
    );
  }
}

class SearchScreenBody extends StatefulWidget {
  final String query;
  const SearchScreenBody({super.key, required this.query});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeViewModel>(
      context,
    ).searchWorkshops(query: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.25,
              child: LoadingIndicator(
                indicatorType: Indicator.ballScaleMultiple,
                colors: const [kMainDarkColor, kMainColor],
                strokeWidth: 1,
                backgroundColor: backgroundColor,
                pathBackgroundColor: Colors.black,
              ),
            ),
          );
        } else if (state.uiState == UiState.error) {
          return NoInternetWidget(
            errorMessage: state.erroemessage ?? '',
            onTap: () {
              BlocProvider.of<HomeViewModel>(
                context,
              ).searchWorkshops(query: widget.query);
            },
          );
        }

        if (state.hasSearched) {
          if (state.searchedWorkshops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no-results.png',
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'لا توجد نتائج مطابقة ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            itemCount: state.searchedWorkshops.length,
            itemBuilder: (context, index) {
              return WorkshopCard(
                workshop: state.searchedWorkshops[index],
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        workshop: state.searchedWorkshops[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }

        return SizedBox();
      },
    );
  }
}
