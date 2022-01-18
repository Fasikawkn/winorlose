import 'package:flutter/material.dart';
import 'package:winorlose/src/models/match_event_model.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/models/services/data_provider/match_data_provider.dart';

class MatchRepository {
  final MatchDataProvider dataProvider;

  MatchRepository({
    required this.dataProvider,
  });

  Future<List<GameMatch>> getCompletedMatch() async {
    print("Getting data");
    final _jsonResponse = await dataProvider.getCompletedMatch();
    final _jsonList = _jsonResponse['games_end'] as List;
    return _jsonList.map((match) => GameMatch.fromJson(match)).toList();
  }

  Future<GameOdd> getGameOdd(String gameId) async {
    final _jsonResponse = await dataProvider.getGameOdd(gameId);
    final _oddss = _jsonResponse['odds'];
    if (_oddss.isEmpty) {
      return GameOdd(homeOd: 'N/A', drawOd: "N/A", awayOd: "N/A");
    }
    final _odds = _jsonResponse['odds'] as Map<String, dynamic>;
    final _bet365 = _odds['Bet365'];
    if (_bet365 == null) {
      return GameOdd(homeOd: 'N/A', drawOd: "N/A", awayOd: "N/A");
    }
    final _prematch = _bet365['prematch'] as List;
    return GameOdd.fromJson(_prematch[0]);
  }

  Future<GameEvent> getGameMatchEvent(String gameId) async {
    final _jsonResponse = await dataProvider.getGameMatchEvent(gameId);
    debugPrint('The event response is $_jsonResponse');
    final _result = _jsonResponse['results'] as List;
    final _stats = _result[0]['stats'];
    debugPrint(
      'The event response is $_stats',
    );
    return GameEvent.fromJson(_stats);
  }
}
