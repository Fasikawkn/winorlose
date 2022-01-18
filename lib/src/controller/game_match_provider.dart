import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:winorlose/src/models/api/api_response.dart';
import 'package:winorlose/src/models/match_event_model.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/models/services/respository/match_respository.dart';

class GameMatchModel extends ChangeNotifier {
  final MatchRepository repository;
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

  Future getCompletedMatch() async {
    response = Response.loading('fetching match');
    try {
      List<GameMatch> _gameMatchResponse = await repository.getCompletedMatch();
      debugPrint("$_gameMatchResponse");
      List<GameMatch> _winnedGames = [];
      for (int i = 0; i < _gameMatchResponse.length; i++) {
        if (_winnedGames.length > 10) {
          break;
        }
        GameMatch _gameMatch = _gameMatchResponse[i];
        String _score = _gameMatch.score;
        if (_score.isNotEmpty) {
          List<String> _scoreResult = _score.split(':');
          int _teamOneScore = int.parse(_scoreResult[0]);
          int _teamTwoScore = int.parse(_scoreResult[1]);
          if (_teamTwoScore > _teamOneScore || _teamTwoScore < _teamOneScore) {
            _winnedGames.add(_gameMatch);
            response = Response.completed(_gameMatch);
          }
        }
      }
      debugPrint('Getting data is ${_winnedGames.length}');
      response = Response.completed(_winnedGames);
      winnedResponse = Response.completed(
          _winnedGames[Random().nextInt(_winnedGames.length)]);
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
