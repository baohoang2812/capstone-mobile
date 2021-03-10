import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/models.dart';
import '../../../../Api/Exceptions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final http.Client httpClient;
  BaseApi baseApi = BaseApi();

  UserApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<String> signIn(String username, String password) async {
    final authenUrl = 'auth/login';
    final body = <String, dynamic>{'username': username, 'password': password};

    final userJson =
        await baseApi.post(authenUrl, body, null) as Map<String, dynamic>;

    if (userJson["code"] != 200) {
      throw Exception('Unauthenticated !');
    }

    return userJson['data']['accessToken'];
  }

  Future<User> getProfile(
    String token, {
    Map<String, String> opts,
  }) async {
    final url = 'employees/profile';

    final userJson =
        await baseApi.get(url, token, opts: opts) as Map<String, dynamic>;

    if (userJson['code'] != 200) {
      throw AuthenticationException('Error');
    }

    return User.fromJson(userJson);
  }

  Future<String> changePassword({
    @required String token,
    @required String username,
    @required String oldPassword,
    @required String newPassword,
    Map<String, String> opts,
  }) async {
    final url = 'auth/password';

    final body = <String, dynamic>{
      "username": username,
      "password": oldPassword,
      "newPassword": newPassword,
    };

    final responseJson = await baseApi.put(url, body, token);

    if (responseJson['code'] != 200) {
      throw FetchDataException(responseJson['message']);
    }

    return responseJson['message'];
  }
}
