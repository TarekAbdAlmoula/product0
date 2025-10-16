abstract class HomeRepository {
  Future getProducts();
  Future getProductsByCategory(int id);
  Future getCategories();
  Future getAdds();
  Future getFeaturedWorkshops();
  Future getTopRatedWorkshop();
  Future getLocalData({required String key});
  Future getUserPoints();
  Future addPoints({required String action});
}
