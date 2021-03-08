import '../../../../Api/Exceptions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/notification/notification.dart';

class NotificationApi {
  final http.Client httpClient;
  BaseApi _baseApi = BaseApi();
  final notificationUrl = 'notifications';

  NotificationApi({@required this.httpClient});

  Future<List<Notification>> getNotifications({
    @required String token,
    double page,
    int limit,
    String sort,
    Map<String, String> opts,
  }) async {
    String url = notificationUrl + '?';

    if (sort != null) {
      url += '&Sort.Orders=$sort';
    }
    if (page != null) {
      url += '&PageIndex=${page.ceil()}';
    }
    if (limit != null) {
      url += '&Limit=$limit';
    }

    final notificationJson = await _baseApi.get(url, token, opts: opts);

    if (notificationJson['code'] != 200) {
      throw FetchDataException(notificationJson['message']);
    }

    final notifications = notificationJson['data']['result'] as List;
    return notifications
        .map((notification) => Notification.fromJson(notification))
        .toList();
  }
}