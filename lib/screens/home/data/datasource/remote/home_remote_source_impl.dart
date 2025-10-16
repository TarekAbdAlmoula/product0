import 'dart:async';

import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/home/data/datasource/remote/home_remote_source.dart';

class HomeRemoteSourceImpl implements HomeRemoteSource {
  final ApiConsumer api;
  HomeRemoteSourceImpl({required this.api});
  @override
  Future getProducts() async {
    var response = await api.get(
      'https://barmijha.net/test/wp-json/wc/v3/products?_fields=id,name,short_description,price,images,featured,rating_count&per_page=100',
    );
    return response;
  }

  @override
  Future getCategories() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/services_categories?parent=0',
    );
    return response;
  }

  @override
  Future getProductsByCategory(int id) async {
    var response = await api.get(
      'https://barmijha.net/test/wp-json/wc/v3/products?category=$id&_fields=id,name,price,images,rating_count,featured,short_description&per_page=100',
    );
    return response;
  }

  @override
  Future getAdds() async {
    // try{}catch
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/wp/v2/ads?_fields=id,title,featured_image_url',
    );
    return response;
  }

  @override
  Future getFeaturedWorkshops() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/services_simple?is_featured=true',
    );
    return response;
  }

  @override
  Future getTopRatedWorkshop() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/services_simple',
    );
    return response;
  }

  @override
  Future getUserPoints({required String token}) async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
      token: token,
    );

    return response['points'];
  }

  @override
  Future addPoints({required String action, required String token}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
      data: {"action": action},
      token: token,
    );
  }
}
