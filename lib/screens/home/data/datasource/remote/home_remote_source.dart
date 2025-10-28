abstract class HomeRemoteSource {
  Future getProducts();
  Future getCategories();
  Future getProductsByCategory(int id);
  Future getAdds();
  Future getFeaturedWorkshops();
  Future getTopRatedWorkshop();
  Future getUserPoints({required String token});
  Future addPoints({required String action, required String token});
  Future searchWorkshops({required String query});
}
