import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product0/constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/components/body.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/datasource/home_remote_source_impl.dart';
import 'package:product0/screens/home/ui/viewmode/home_State.dart';
import 'package:product0/screens/home/ui/viewmode/home_viewmodel.dart';

import 'components/upper_body.dart';

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
        backgroundColor: Color(0xfffffffe),
        body: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            if (state.uiState == UiState.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.uiState == UiState.data) {
              return Stack(
                children: [
                  Body(prod: state.prod, categories: state.categories),
                  UpperBody(),
                ],
              );
            } else {
              return Text('There is an error');
            }
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg", color: kTextColor),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg", color: kTextColor),
          onPressed: () {},
        ),
      ],
    );
  }
}
