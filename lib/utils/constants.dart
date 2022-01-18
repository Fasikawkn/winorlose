// colors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winorlose/src/models/api/api_exception.dart';

const kYellowColor = Color(0xffee793b);

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error occured while communication with server' +
          ' with status code : ${response.statusCode}');
  }
}

class CustomFunctions {
  static String getDate(String timeStamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return "${date.day < 10 ? '0${date.day}' : date.day}.${date.month < 10 ? '0${date.month}' : date.month}.${date.year.toString().substring(2)}";
  }

  static String getTime(String timeStamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return "${date.hour < 10 ? '0${date.hour}' : date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}";
  }
}

