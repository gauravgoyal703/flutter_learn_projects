import 'dart:async';

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shoppinglist/exception/exception_handler.dart';

class BaseClient {
  static const int timeOutDuration = 35;

  //GET
  Future<dynamic> get(Uri uri) async {
    try {
      var response =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } catch (error, stack) {
      log('Error while getting data. [error=${error.toString()}]',
          stackTrace: stack);
      throw ExceptionHandlers().getExceptionString(error);
    }
  }

  //POST
  Future<dynamic> post(
      Uri uri, Map<String, String> headers, dynamic payloadObj) async {
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));

      return _processResponse(response);
    } catch (error, stack) {
      log('Error while adding data: [error=${error.toString()}]',
          stackTrace: stack);
      throw ExceptionHandlers().getExceptionString(error);
    }
  }

  //DELETE
  Future<dynamic> delete(
      Uri uri, Map<String, String> headers, dynamic payloadObj) async {
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .delete(uri, headers: headers, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));

      return _processResponse(response);
    } catch (error, stack) {
      log('Error while removing data: [error=${error.toString()}]',
          stackTrace: stack);
      throw ExceptionHandlers().getExceptionString(error);
    }
  }
  //OTHERS

//----------------------ERROR STATUS CODES----------------------

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.body)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.body)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }
}
