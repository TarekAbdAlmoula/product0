import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product0/core/components/no_internet_widget.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/ui/details_screen.dart';
import 'package:product0/screens/workshops/data/repository/workshops_repository_impl.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_viewmodel.dart';
import 'package:product0/screens/workshops/ui/workshop_card.dart';
import 'package:product0/screens/workshops/data/datasource/workshops_remote_source_impl.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_state.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });
  final int categoryId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: kMainDarkColor,
        title: Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProductsViewmodel(
          productsRepositoryImpl: WorkshopsRepositoryImpl(
            productsRemoteSourceImpl: WorkshopsRemoteSourceImpl(
              DioConsumer(
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
        child: WorkshopsScreenBody(categoryId: categoryId),
      ),
    );
  }
}

class WorkshopsScreenBody extends StatefulWidget {
  final int categoryId;
  const WorkshopsScreenBody({super.key, required this.categoryId});
  @override
  State<WorkshopsScreenBody> createState() => _WorkshopsScreenBodyState();
}

class _WorkshopsScreenBodyState extends State<WorkshopsScreenBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsViewmodel>(
      context,
    ).getProductsByCategory(id: widget.categoryId);
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewmodel, ProductsState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return Center(child: CircularProgressIndicator(color: kMainColor));
        } else if (state.uiState == UiState.data) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: 5.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    enabled: (state.token.isEmpty) ? false : true,
                    onSubmitted: (value) async {
                      BlocProvider.of<ProductsViewmodel>(
                        context,
                      ).searchedWorkshop(
                        query: searchController.text,
                        id: widget.categoryId,
                      );
                    },
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        await BlocProvider.of<ProductsViewmodel>(
                          context,
                        ).refreshWorkShop();
                      }
                    },
                    controller: searchController,
                    cursorColor: kMainColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: (state.token.isEmpty)
                          ? 'سجل دخول وابحث أسرع'
                          : 'بحث ...',
                      prefixIcon: IconButton(
                        onPressed: () {
                          BlocProvider.of<ProductsViewmodel>(
                            context,
                          ).searchedWorkshop(
                            query: searchController.text,
                            id: widget.categoryId,
                          );
                        },
                        icon: Icon(Icons.search, color: Colors.grey, size: 30),
                      ),
                    ),
                  ),
                ),
                state.uiState == UiState.loading
                    ? CircularProgressIndicator()
                    : Flexible(
                        child: ListView.builder(
                          itemCount: state.searchedWorkshop!.isEmpty
                              ? state.workshop.length
                              : state.searchedWorkshop!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      workshop: state.workshop[index],
                                    ),
                                  ),
                                );
                              },
                              child: WorkshopCard(
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        workshop:
                                            state.searchedWorkshop!.isEmpty
                                            ? state.workshop[index]
                                            : state.searchedWorkshop![index],
                                      ),
                                    ),
                                  );
                                },
                                workshop: state.searchedWorkshop!.isEmpty
                                    ? state.workshop[index]
                                    : state.searchedWorkshop![index],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        } else if (state.uiState == UiState.error) {
          return NoInternetWidget(
            errorMessage: state.erroemessage ?? '',
            onTap: () async {
              BlocProvider.of<ProductsViewmodel>(
                context,
              ).getProductsByCategory(id: widget.categoryId);
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
