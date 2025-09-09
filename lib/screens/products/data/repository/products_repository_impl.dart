import 'package:product0/screens/home/data/model/prod.dart';
import 'package:product0/screens/products/data/datasource/products_remote_source_impl.dart';
import 'package:product0/screens/products/data/repository/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteSourceImpl productsRemoteSourceImpl;

  ProductsRepositoryImpl({required this.productsRemoteSourceImpl});
  @override
  Future getProductsByCategory(int id) async {
    var response = await productsRemoteSourceImpl.getProductsByCategory(id);
    List<Prod> prod = [];
    for (var data in response) {
      prod.add(Prod.fromJson(data));
    }
    return prod;
  }
}
