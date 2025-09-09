abstract class HomeRepository {
  Future getProducts();
  Future getProductsByCategory(int id);
  Future getCategories();
}
