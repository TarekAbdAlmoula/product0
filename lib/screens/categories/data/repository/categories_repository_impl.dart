import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/categories/data/datasource/categories_remote_source.dart';
import 'package:product0/screens/categories/data/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteSource categoriesRemoteSource;
  CategoriesRepositoryImpl({required this.categoriesRemoteSource});
  @override
  Future getCategoriesById(int id) async {
    try {
      List<Categories> categories = [];
      var response = await categoriesRemoteSource.getCategoriesById(id);
      for (var data in response) {
        categories.add(Categories.fromJson(data));
      }
      return categories;
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
