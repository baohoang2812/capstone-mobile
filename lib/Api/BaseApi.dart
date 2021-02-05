import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'Exceptions.dart';

class BaseApi {
  final String _baseUrl = "https://api-mavca.azurewebsites.net/v1/";

  Map<String, String> generateHeader(
    String token, [
    Map<String, String> opts,
  ]) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      ...?opts,
    };
  }

  Future<dynamic> get(
    String url,
    String token, {
    Map<String, String> opts,
  }) async {
    var responseJson;
    try {
      final response =
          await http.get(_baseUrl + url, headers: generateHeader(token, opts));
      responseJson = _returnResponse(response);
    } catch (e) {
      print(e);
      // throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> post(
    String url,
    dynamic body,
    String token, {
    Map<String, String> opts,
  }) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          headers: generateHeader(token, opts),
          body: jsonEncode(<String, dynamic>{...body}));
      responseJson = _returnResponse(response);
    } catch (e) {
      // throw FetchDataException(e);
      print(e);
    }

    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body,
    String token, {
    Map<String, String> opts,
  }) async {
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url,
          headers: generateHeader(token, opts),
          body: jsonEncode(<String, String>{...body}));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> delete(
    String url,
    String token, {
    Map<String, String> opts,
  }) async {
    var responseJson;
    try {
      final response = await http.delete(
        _baseUrl + url,
        headers: generateHeader(token, opts),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    String body = response.body.toString();
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(body);
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = jsonDecode(body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(body);
      case 401:
        throw BadRequestException(body);
      case 403:
        throw UnauthorisedException(body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
