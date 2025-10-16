abstract class DetailsRemoteSource {
  Future sendRating(
    num rating,
    int workshopId,
    String token, {
    String? comment,
  });
}
