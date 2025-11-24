import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/workshops/data/datasource/workshops_remote_source_impl.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/workshops/data/repository/workshops_repository.dart';

class WorkshopsRepositoryImpl extends WorkshopsRepository {
  final WorkshopsRemoteSourceImpl productsRemoteSourceImpl;

  WorkshopsRepositoryImpl({required this.productsRemoteSourceImpl});
  @override
  Future getProductsByCategory(int id) async {
    try {
      var response = await productsRemoteSourceImpl.getProductsByCategory(id);
      List<Workshop> workshop = [];
      for (var data in response) {
        workshop.add(Workshop.fromJson(data));
      }
      return workshop;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future searchedWorkshop({required String query, required int id}) async {
    try {
      var response = await productsRemoteSourceImpl.searchedWorkshop(
        id: id,
        query: query,
      );
      List<Workshop> searchedWorkshop = [];
      for (var data in response) {
        searchedWorkshop.add(Workshop.fromJson(data));
      }

      return searchedWorkshop;
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
