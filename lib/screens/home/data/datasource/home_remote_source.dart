abstract class HomeRemoteSource {
  Future getProducts();
  Future getCategories();
  Future getProductsByCategory(int id);
  Future getAdds();
  Future getFeaturedWorkshops();
  Future getTopRatedWorkshop();
}
