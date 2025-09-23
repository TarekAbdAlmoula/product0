import 'package:product0/screens/premieum/data/model/premieum.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source.dart';
import 'package:product0/screens/premieum/data/repository/premieum_repository.dart';

class PremieumRepositoryImpl implements PremieumRepository {
  PremieumRemoteSource premieumRemoteSource;
  PremieumRepositoryImpl({required this.premieumRemoteSource});
  @override
  Future getPlans() async {
    List<Premieum> premieum = [];
    var response = await premieumRemoteSource.getPlans();
    for (var data in response) {
      premieum.add(Premieum.fromJson(data));
    }
    return premieum;
  }
}
