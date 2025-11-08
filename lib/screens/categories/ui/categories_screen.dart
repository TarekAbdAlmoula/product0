import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/no_internet_widget.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/categories/data/datasource/categories_remote_source_impl.dart';
import 'package:product0/screens/categories/data/repository/categories_repository_impl.dart';
import 'package:product0/screens/categories/ui/viewmodel/categories_state.dart';
import 'package:product0/screens/categories/ui/viewmodel/categories_viewmodel.dart';
import 'package:product0/screens/workshops/ui/workshop_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.id, required this.name});
  final int id;
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesViewmodel(
        categoriesRepository: CategoriesRepositoryImpl(
          categoriesRemoteSource: CategoriesRemoteSourceImpl(
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
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(name, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kMainDarkColor,
        ),
        body: CategoriesScreenBody(id: id),
      ),
    );
  }
}

class CategoriesScreenBody extends StatefulWidget {
  const CategoriesScreenBody({super.key, required this.id});
  final int id;

  @override
  State<CategoriesScreenBody> createState() => _CategoriesScreenBodyState();
}

class _CategoriesScreenBodyState extends State<CategoriesScreenBody> {
  @override
  void initState() {
    BlocProvider.of<CategoriesViewmodel>(context).getCategoriesById(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesViewmodel, CategoriesState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return Center(child: CircularProgressIndicator(color: kMainColor));
        } else if (state.uiState == UiState.data) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
            itemCount: state.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 30.w,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkshopsScreen(
                        categoryId: state.categories[index].id,
                        title: state.categories[index].name,
                      ),
                    ),
                  );
                },
                child: CategoriesCardV2(categories: state.categories[index]),
              );
            },
          );
        } else if (state.uiState == UiState.error) {
          return NoInternetWidget(
            errorMessage: state.erroemessage ?? '',
            onTap: () async {
              await BlocProvider.of<CategoriesViewmodel>(
                context,
              ).getCategoriesById(widget.id);
            },
          );
        } else {
          return Text('');
        }
      },
    );
  }
}

class CategoriesCardV2 extends StatelessWidget {
  const CategoriesCardV2({super.key, required this.categories});
  final Categories categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(categories.image!.ulr),
          radius: 43.r,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 20.h,
          width: 80.w,
          child: Text(
            categories.name,
            style: TextStyle(fontSize: 15.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
