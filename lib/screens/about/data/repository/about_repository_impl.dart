import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/about/data/datasource/remote/about_remote_source.dart';
import 'package:product0/screens/about/data/model/about.dart';
import 'package:product0/screens/about/data/repository/about_repository.dart';

class AboutRepositoryImpl implements AboutRepository {
  final AboutRemoteSource aboutRemoteSource;
  AboutRepositoryImpl({required this.aboutRemoteSource});
  @override
  Future fetchAboutInfo() async {
    try {
      var response = await aboutRemoteSource.getAboutInfo();
      List<About> about = [];
      for (var data in response) {
        about.add(About.fromJson(data));
        return about;
      }
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
