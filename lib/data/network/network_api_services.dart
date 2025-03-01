import 'package:zubair_onward_academy/data/network/base_api_services.dart';
import 'package:zubair_onward_academy/data/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class NetworkApiServices extends BaseApiServices {

  @override
  Future getGetApiResponse(String url, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers).timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      ).timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        final errorResponse = jsonDecode(response.body);
        if (errorResponse['error'] != null && errorResponse['error']['msg'] != null) {
          throw BadRequestException(errorResponse['error']['msg']);
        }
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
          'Error while communicating with server: ${response.statusCode}',
        );
    }
  }

}
