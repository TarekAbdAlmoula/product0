import 'package:image_picker/image_picker.dart';

abstract class PremieumRemoteSource {
  Future getPlans();
  Future uploadImages({
    required List<XFile>? images,
    required String token,
    required String productName,
    required String productDescription,
    required String location,
    required String phoneNumber,
    String price,
  });
}
