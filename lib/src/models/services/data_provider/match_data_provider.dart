import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winorlose/src/models/api/api_exception.dart';
import 'package:winorlose/utils/constants.dart';

class MatchDataProvider {
  final http.Client httpClient;

  MatchDataProvider({
    required this.httpClient,
  });

  Future<dynamic> getCompletedMatch() async {
    DateTime _time = DateTime.now();
    print("The date is$_time");
    int number1 = Random().nextInt(2) + 1;
   _time =  _time.subtract( Duration(days: number1));
    print("The date is ${_time}");
    final _date =
        '${_time.year}${_time.month < 10 ? "0${_time.month}" : _time.month}${_time.day < 10 ? "0${_time.day}" : _time.day}';
          int _randomNumber = Random().nextInt(2) + 1;
    print('THe random number is $_randomNumber');
    final _url =
        'https://spoyer.ru/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=enddatapage&sport=soccer&day=$_date&p=$_randomNumber';
    print(_url);
    late dynamic _apiResponse;
    try {
      final _jsonResposne = await httpClient.get(
        Uri.parse(
          _url,
        ),
      );
      print('The response is ${_jsonResposne.body}');
      _apiResponse = returnResponse(_jsonResposne);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

  Future<dynamic> getGameOdd(String gameId) async {
    late dynamic _apiResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(
          "https://spoyer.ru/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=odds&game_id=" +
              gameId,
        ),
      );
      _apiResponse = returnResponse(_response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }

  Future<dynamic> getGameMatchEvent(String gameId) async {
    debugPrint("Fetch game event");
    late dynamic _apiResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(
          "https://spoyer.ru/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=eventdata&game_id=" +
              gameId,
        ),
      );
      _apiResponse = returnResponse(_response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return _apiResponse;
  }
}
