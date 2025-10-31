import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:product0/core/api/dio_consumer.dart';
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
        homeRepositoryImpl: HomeRepositoryImpl(
          homeLocalSourceImpl: HomeLocalSourceImpl(),
          homeRemoteSourceImpl: HomeRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
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
    // TODO: implement initState
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
            child: LoadingIndicator(
              indicatorType: Indicator.ballScaleMultiple,
              colors: const [kMainDarkColor, kMainColor],
              strokeWidth: 1,
              backgroundColor: backgroundColor,
              pathBackgroundColor: Colors.black,
            ),
          );
        }

        if (state.hasSearched) {
          if (state.uiState == UiState.error) {
            return const Center(child: Text('حدث خطأ أثناء البحث '));
          }

          if (state.searchedWorkshops.isEmpty) {
            return const Center(child: Text('لا توجد نتائج مطابقة '));
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
