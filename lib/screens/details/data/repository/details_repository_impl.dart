import 'package:product0/screens/details/data/remote/details_remote_source_impl.dart';
import 'package:product0/screens/details/data/repository/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteSourceImpl detailsRemoteSourceImpl;
  DetailsRepositoryImpl({required this.detailsRemoteSourceImpl});
  @override
  Future sendRating(num rating, int workshopId) async {
    num newRating = await detailsRemoteSourceImpl.sendRating(
      rating,
      workshopId,
    );
    return newRating;
  }
}
