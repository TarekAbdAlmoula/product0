abstract class DetailsRemoteSource {
  Future sendRating(
    num rating,
    int workshopId,
    String token, {
    String? comment,
  });
  Future callService({required String token, required String workshopId});
}
