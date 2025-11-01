import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/datasource/local/home_local_source_impl.dart';
import 'package:product0/screens/home/data/model/ads.dart';
import 'package:product0/screens/home/data/model/prod.dart';
import 'package:product0/screens/home/data/resposirory/home_repository.dart';
import 'package:product0/screens/home/data/datasource/remote/home_remote_source_impl.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalSourceImpl homeLocalSourceImpl;
  final HomeRemoteSourceImpl homeRemoteSourceImpl;
  HomeRepositoryImpl({
    required this.homeRemoteSourceImpl,
    required this.homeLocalSourceImpl,
  });
  @override
  Future getProducts() async {
    try {
      var response = await homeRemoteSourceImpl.getProducts();
      List<Prod> prod = [];
      for (var data in response) {
        prod.add(Prod.fromJson(data));
      }
      prod.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));
      return prod;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getCategories() async {
    try {
      var response = await homeRemoteSourceImpl.getCategories();
      List<Categories> categories = [];
      for (var data in response) {
        categories.add(Categories.fromJson(data));
      }

      return categories;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getProductsByCategory(int id) async {
    try {
      var response = await homeRemoteSourceImpl.getProductsByCategory(id);
      List<Prod> prod = [];
      for (var data in response) {
        prod.add(Prod.fromJson(data));
      }
      return prod;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getAdds() async {
    try {
      final String token = await homeLocalSourceImpl.getLocalData('token');
      var response = await homeRemoteSourceImpl.getAdds(token: token);
      Ads adds;
      adds = Ads.fromJson(response);
      return adds;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getFeaturedWorkshops() async {
    try {
      List<Workshop> workshop = [];
      var response = await homeRemoteSourceImpl.getFeaturedWorkshops();
      for (var data in response) {
        workshop.add(Workshop.fromJson(data));
      }
      workshop.sort((a, b) {
        return b.rating.compareTo(a.rating);
      });
      return workshop;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getTopRatedWorkshop() async {
    try {
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
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getLocalData({required String key}) async {
    return await homeLocalSourceImpl.getLocalData(key);
  }

  @override
  Future getUserPoints() async {
    try {
      final String token = await homeLocalSourceImpl.getLocalData('token');
      return await homeRemoteSourceImpl.getUserPoints(token: token);
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future addPoints({required String action}) async {
    try {
      final String token = await homeLocalSourceImpl.getLocalData('token');
      String pointMessage = await homeRemoteSourceImpl.addPoints(
        action: action,
        token: token,
      );

      return pointMessage;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future searchWorkshops({required String query}) async {
    try {
      List<Workshop> searchedWorkshops = [];
      var response = await homeRemoteSourceImpl.searchWorkshops(query: query);
      for (var data in response) {
        searchedWorkshops.add(Workshop.fromJson(data));
      }
      return searchedWorkshops;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future getPointsExpl() async {
    try {
      var response = await homeRemoteSourceImpl.getPointsExpl();
      return response;
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
