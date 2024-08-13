import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/user_model.dart';
import '../../res/urls/app_urls.dart';

class LoginRepository {
  final BaseApiServices _network = NetworkApiServices();

  Future<UserModel> loginApi(dynamic data) async {
    final response =
        await _network.getPostApiResponse(AppUrls.loginEndPoint, data);
    return UserModel.fromJson(response);
  }
}
