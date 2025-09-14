import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/constants.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/details_screen.dart';
import 'package:product0/screens/home/components/item_card.dart';
import 'package:product0/screens/products/data/datasource/products_remote_source_impl.dart';
import 'package:product0/screens/products/data/repository/products_repository_impl.dart';
import 'package:product0/screens/products/ui/viewmode/products_state.dart';
import 'package:product0/screens/products/ui/viewmode/products_viewmodel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
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
          productsRepositoryImpl: ProductsRepositoryImpl(
            productsRemoteSourceImpl: ProductsRemoteSourceImpl(
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
          return Center(child: CircularProgressIndicator(color: Colors.red));
        } else if (state.uiState == UiState.data) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
              crossAxisCount: 2,
            ),
            itemCount: state.prodByCategory.length,
            itemBuilder: (context, index) {
              return ItemCard(
                press: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(prod: state.prodByCategory[index]),
                    ),
                  );
                },
                prod: state.prodByCategory[index],
              );
            },
          );
        } else {
          return Text('There is an Error');
        }
      },
    );
  }
}
