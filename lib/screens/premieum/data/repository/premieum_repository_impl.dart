import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source.dart';
import 'package:product0/screens/premieum/data/repository/premieum_repository.dart';
import 'package:image_picker/image_picker.dart';

class PremieumRepositoryImpl implements PremieumRepository {
  PremieumRemoteSource premieumRemoteSource;
  PremieumRepositoryImpl({required this.premieumRemoteSource});
  @override
  Future getPlans() async {
    try {
      List<Premieum> premieum = [];
      var response = await premieumRemoteSource.getPlans();
      for (var data in response) {
        premieum.add(Premieum.fromJson(data));
      }
      return premieum;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future pickImages() async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? picked = await picker.pickMultiImage(imageQuality: 60);
    return picked;
  }

  @override
  Future uploadImages({
    required Object? images,
    required String token,
    required String productName,
    required String productDescription,
    required String location,
    required String phoneNumber,
    String price = '',
  }) async {
    try {
      bool isSuccess = await premieumRemoteSource.uploadImages(
        images: images as List<XFile>?,
        token: token,
        productName: productName,
        productDescription: productDescription,
        location: location,
        phoneNumber: phoneNumber,
        price: price,
      );
      return isSuccess;
    } on ServerException catch (e) {
      throw e.message;
    }
  }
}
