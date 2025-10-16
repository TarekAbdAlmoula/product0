import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/notification/data/datasource/notification_remote_source_impl.dart';
import 'package:product0/screens/notification/data/model/notification.dart';
import 'package:product0/screens/notification/data/repository/notification_repository_impl.dart';
import 'package:product0/screens/notification/ui/viewmodel/notification_State.dart';
import 'package:product0/screens/notification/ui/viewmodel/notification_viewmodel.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Builds the widget tree for the NotificationScreen.
  ///
  /// It returns a BlocProvider which creates an instance of NotificationViewmodel
  /// and uses it to build the widget tree.
  /*******  b90b8ee7-619d-4245-a4a8-a3bb6c95a6e2  *******/
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationViewmodel(
        notificationRepositoryImpl: NotificationRepositoryImpl(
          notificationRemoteSource: NotificationRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Text('الاشعارات', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: NotificationScreenBody(),
      ),
    );
  }
}

class NotificationScreenBody extends StatelessWidget {
  const NotificationScreenBody({super.key});

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Builds the widget tree for the NotificationScreen.
  ///
  /// It returns a BlocProvider which creates an instance of NotificationViewmodel
  /// and uses it to build the widget tree.
  ///
  /// The widget tree is built according to the state of the NotificationViewmodel.
  /// If the state is loading, it shows a CircularProgressIndicator.
  /// If the state is data, it shows a listview of NotificationCard widgets.
  /// If the state is error, it shows a Text widget with an error message.
  /*******  6ee14a56-2869-45db-9697-b44a2be9de82  *******/
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationViewmodel, NotificationState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return Center(child: CircularProgressIndicator(color: kMainColor));
        } else if (state.uiState == UiState.data) {
          return ListView.builder(
            itemCount: state.notification.length,
            itemBuilder: (context, index) {
              return NotificationCard(notification: state.notification[index]);
            },
          );
        } else if (state.uiState == UiState.error) {
          return Center(child: Text('حدث خطأ'));
        } else {
          return Center(child: Text('لا يوجد اشعارات'));
        }
      },
    );
  }
}
//create notification card and send the parameters

class NotificationCard extends StatelessWidget {
  final Notifications notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,

      decoration: BoxDecoration(
        border: Border.all(color: kMainColor),
        color: kMainDarkColor.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ' : ${notification.title}',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              notification.content,
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(notification.date.substring(0, 10)),
        ],
      ),
    );
  }
}
