import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/products/data/datasource/products_remote_source.dart';

class ProductsRemoteSourceImpl extends ProductsRemoteSource {
  final ApiConsumer api;
  ProductsRemoteSourceImpl(this.api);
  @override
  Future getProductsByCategory(int id) async {
    var response = await api.get(
      'https://barmijha.net/test/wp-json/wc/v3/products?category=$id&_fields=id,name,price,images,rating_count,featured,short_description&per_page=100',
    );
    print('------------------->$response');
    return response;
  }
}
