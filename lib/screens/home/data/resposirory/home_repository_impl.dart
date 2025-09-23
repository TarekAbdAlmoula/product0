import 'package:product0/models/categories.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/model/prod.dart';
import 'package:product0/screens/home/data/resposirory/home_repository.dart';
import 'package:product0/screens/home/data/datasource/home_remote_source_impl.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteSourceImpl homeRemoteSourceImpl;
  HomeRepositoryImpl({required this.homeRemoteSourceImpl});
  @override
  Future getProducts() async {
    var response = await homeRemoteSourceImpl.getProducts();
    List<Prod> prod = [];
    for (var data in response) {
      prod.add(Prod.fromJson(data));
    }
    prod.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));
    return prod;
  }

  @override
  Future getCategories() async {
    var response = await homeRemoteSourceImpl.getCategories();
    List<Categories> categories = [];
    for (var data in response) {
      categories.add(Categories.fromJson(data));
    }

    return categories;
  }

  @override
  Future getProductsByCategory(int id) async {
    var response = await homeRemoteSourceImpl.getProductsByCategory(id);
    List<Prod> prod = [];
    for (var data in response) {
      prod.add(Prod.fromJson(data));
    }
    return prod;
  }

  @override
  Future getAdds() async {
    var response = await homeRemoteSourceImpl.getAdds();
    List<String> adds = [];
    for (var data in response) {
      adds.add(data['featured_image_url']);
    }
    return adds;
  }

  @override
  Future getFeaturedWorkshops() async {
    List<Workshop> workshop = [];
    var response = await homeRemoteSourceImpl.getFeaturedWorkshops();
    for (var data in response) {
      workshop.add(Workshop.fromJson(data));
    }
    workshop.sort((a, b) {
      return b.rating.compareTo(a.rating);
    });
    return workshop;
  }

  @override
  Future getTopRatedWorkshop() async {
    var response = await homeRemoteSourceImpl.getTopRatedWorkshop();
    List<Workshop> topRatedWorkshop = [];
    for (var data in response) {
      if (((data['average_rating'] / 5) * 100) >= 50) {
        topRatedWorkshop.add(Workshop.fromJson(data));
      }
    }
    topRatedWorkshop.sort((a, b) {
      return b.rating.compareTo(a.rating);
    });
    return topRatedWorkshop;
  }
}
