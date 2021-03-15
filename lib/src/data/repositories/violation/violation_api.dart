import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:meta/meta.dart';
import '../../../../Api/Exceptions.dart';
import 'package:date_util/date_util.dart';
import 'package:http/http.dart' as http;

class ViolationApi {
  final http.Client httpClient;
  BaseApi _baseApi = BaseApi();
  final violationUrl = 'violations';

  ViolationApi({@required this.httpClient});

  Future<int> createViolations({
    @required String token,
    @required List<Violation> violations,
    Map<String, String> opts,
  }) async {
    final body = [
      ...Violation.convertListViolationToListMap(violations),
    ];

    final result = await _baseApi.post(violationUrl, body, token, opts: opts);

    return result['code'];
  }

  Future<List<Violation>> getViolations({
    @required String token,
    Map<String, String> opts,
    String sort,
    double page,
    int limit,
    String status,
    int branchId,
    int regulationId,
    DateTime date,
  }) async {
    String url = violationUrl + '?Filter.IsDeleted=false';
    if (sort != null) {
      url += '&Sort.Orders=$sort';
    }
    if (page != null) {
      url += '&PageIndex=${page.ceil()}';
    }
    if (limit != null) {
      url += '&Limit=$limit';
    }
    if (status != null) {
      url += '&Filter.Status=$status';
    }
    if (regulationId != null) {
      url += '&Filter.Name=$regulationId';
    }
    if (branchId != null) {
      url += '&Filter.BranchIds=$branchId';
    }
    if (date != null) {
      var dateUtility = DateUtil();
      var month = date.month;
      var year = date.year;
      var daysInMonth = dateUtility.daysInMonth(month, year);
      var from = '$year-$month-01';
      var to = '$year-$month-$daysInMonth';

      url += '&Filter.FromDate=$from';
      url += '&Filter.ToDate=$to';
    }

    final violationJson = await _baseApi.get(url, token);

    if (violationJson['code'] != 200) {
      throw FetchDataException(violationJson['message']);
    }

    final violations = violationJson['data']['result'] as List;
    return violations
        .map(
          (violation) => Violation.fromJson(violation),
        )
        .toList();
  }

  Future<int> editViolation({
    @required String token,
    @required Violation violation,
    Map<String, String> opts,
  }) async {
    final url = violationUrl + '/' + violation.id.toString();
    final body = <String, dynamic>{
      'name': violation.name,
      'imagePath': violation.imagePath,
      'description': violation.description,
      'branchId': violation.branchId,
      'regulationId': violation.regulationId,
      'status': violation.status,
    };

    final result = await _baseApi.put(
      url,
      body,
      token,
      opts: opts,
    );

    return result['code'];
  }

  Future<int> deleteViolation({
    @required String token,
    @required int id,
  }) async {
    final url = violationUrl + '/' + id.toString();

    final result = await _baseApi.delete(url, token);

    return result['code'];
  }
}
