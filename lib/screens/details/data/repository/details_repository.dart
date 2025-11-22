abstract class DetailsRepository {
  Future sendRating(num rating, int workshopId, {String? comment});
  Future callService({required String workshopId});
}
