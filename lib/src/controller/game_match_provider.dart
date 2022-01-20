import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:winorlose/src/models/api/api_response.dart';
import 'package:winorlose/src/models/match_event_model.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/models/services/respository/match_respository.dart';

class GameMatchModel extends ChangeNotifier {
  final MatchRepository repository;
  int _value = 0;
  GameMatchModel({
    required this.repository,
  });
  Response _response = Response.initial('initializing match');

  Response get response {
    return _response;
  }

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Response _eventResponse = Response.initial('initializing odd');

  Response get eventResponse {
    return _eventResponse;
  }

  set eventResponse(Response response) {
    _eventResponse = response;
    notifyListeners();
  }

  Response _winnedResponse = Response.initial('initializing odd');

  Response get winnedResponse {
    return _winnedResponse;
  }

  set winnedResponse(Response response) {
    _winnedResponse = response;
    notifyListeners();
  }

  Future getWinnedGame() async {
    if (response.status == Status.completed) {
      List<GameMatch> _winnedGames = response.data;
      winnedResponse = Response.completed(_winnedGames);
    }
  }

  void switchValue(){
    if(_value == 0){
      _value = 25;
    }else if(_value == 25){
      _value = 0;
    }
    
  }

  Future getCompletedMatch() async {
       print("The random value is $_value");

   switchValue();
   print("The random value is $_value");
  
    
    response = Response.loading('fetching match');
    try {
      List<GameMatch> _gameMatchResponse = await repository.getCompletedMatch();

      // List<GameMatch> _winnedGames = [];
      for (int i = _value  ; i < _gameMatchResponse.length; i++) {
        GameMatch _gameMatch = _gameMatchResponse[i];
        String _score = _gameMatch.score;
        if (_score.isNotEmpty) {
          List<String> _scoreResult = _score.split(':');
          int _teamOneScore = int.parse(_scoreResult[0]);
          int _teamTwoScore = int.parse(_scoreResult[1]);
          if (_teamTwoScore > _teamOneScore || _teamTwoScore < _teamOneScore) {
            response = Response.completed(_gameMatch);
            break;
          }
        }
      }
    
      
    } catch (e) {
      debugPrint("The error is ${e.toString()}");
      response = Response.error(e.toString());
    }
  }

  Future<GameOdd> getOdd(String gameId) async {
    late GameOdd _matchOdd;
    try {
      GameOdd _gameOdd = await repository.getGameOdd(gameId);
      _matchOdd = _gameOdd;
    } catch (e) {
      throw Exception(e.toString());
    }
    return _matchOdd;
  }

  Future getGameMatchevent(String gameId) async {
    eventResponse = Response.loading(
      'fetching events',
    );
    try {
      GameEvent _gameevent = await repository.getGameMatchEvent(gameId);
      eventResponse = Response.completed(_gameevent);
    } catch (e) {
      eventResponse = Response.error(e.toString());
    }
  }
}
