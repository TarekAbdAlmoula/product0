abstract class WorkshopRemoteSource {
  Future getProductsByCategory(int id);
  Future searchedWorkshop({required String query, required int id});
}
