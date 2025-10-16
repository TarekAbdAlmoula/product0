import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/screens/details/data/remote/details_remote_source_impl.dart';
import 'package:product0/screens/details/data/repository/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteSourceImpl detailsRemoteSourceImpl;
  DetailsRepositoryImpl({required this.detailsRemoteSourceImpl});
  @override
  Future sendRating(num rating, int workshopId, {String? comment}) async {
    final FlutterSecureStorage _storage = const FlutterSecureStorage();
    final String? token = await _storage.read(key: 'token');
    num newRating = await detailsRemoteSourceImpl.sendRating(
      rating,
      workshopId,
      token ?? '',
      comment: comment,
    );
    return newRating;
  }
}
