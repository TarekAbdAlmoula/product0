import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/details_screen.dart';
import 'package:product0/screens/workshops/ui/workshop_card.dart';
import 'package:product0/screens/workshops/data/datasource/workshops_remote_source_impl.dart';
import 'package:product0/screens/workshops/data/repository/workshops_repository_impl.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_state.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_viewmodel.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });
  final int categoryId;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ), // لون السهم
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: kMainColor,
        title: Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProductsViewmodel(
          productsRepositoryImpl: WorkshopsRepositoryImpl(
            productsRemoteSourceImpl: WorkshopsRemoteSourceImpl(
              DioConsumer(dio: Dio()),
            ),
          ),
        ),
        child: ProductsScreenBody(categoryId: categoryId),
      ),
    );
  }
}

class ProductsScreenBody extends StatefulWidget {
  final int categoryId;
  const ProductsScreenBody({super.key, required this.categoryId});

  @override
  State<ProductsScreenBody> createState() => _ProductsScreenBodyState();
}

class _ProductsScreenBodyState extends State<ProductsScreenBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsViewmodel>(
      context,
    ).getProductsByCategory(id: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewmodel, ProductsState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return Center(child: CircularProgressIndicator(color: kMainColor));
        } else if (state.uiState == UiState.data) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            itemCount: state.workshop.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(workshop: state.workshop[index]),
                    ),
                  );
                },
                child: ItemCard(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(workshop: state.workshop[index]),
                      ),
                    );
                  },
                  workshop: state.workshop[index],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
