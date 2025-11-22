import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/details/data/model/rating.dart';
import 'package:product0/screens/details/data/remote/details_remote_source_impl.dart';
import 'package:product0/screens/details/data/repository/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteSourceImpl detailsRemoteSourceImpl;
  DetailsRepositoryImpl({required this.detailsRemoteSourceImpl});
  @override
  Future sendRating(num rating, int workshopId, {String? comment}) async {
    try {
      final FlutterSecureStorage storage = const FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      Rating ratingModel;
      var response = await detailsRemoteSourceImpl.sendRating(
        rating,
        workshopId,
        token ?? '',
        comment: comment,
      );
      ratingModel = Rating.fromJson(response);
      return ratingModel;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future callService({required String workshopId}) async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    await detailsRemoteSourceImpl.callService(
      token: token ?? '',
      workshopId: workshopId,
    );
  }
}
