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
      workshop.sort((a, b) {
        if (a.isFeatured == b.isFeatured) {
          return 0;
        } else if (a.isFeatured) {
          return -1;
        } else {
          return 1;
        }
      });
      return workshop;
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
