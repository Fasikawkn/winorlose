// To parse this JSON data, do
//
//     final match = matchFromJson(jsonString);


// Match matchFromJson(String str) => Match.fromJson(json.decode(str));

// String matchToJson(Match data) => json.encode(data.toJson());

class GameMatch {
    GameMatch({
      required  this.gameId,
      required  this.time,
      required  this.timeStatus,
      required  this.league,
      required  this.home,
      required  this.away,
      required  this.score,
    });

    String gameId;
    String time;
    String timeStatus;
    Away league;
    Away home;
    Away away;
    String score;

    factory GameMatch.fromJson(Map<String, dynamic> json) => GameMatch(
        gameId: json["game_id"],
        time: json["time"],
        timeStatus: json["time_status"],
        league: Away.fromJson(json["league"]),
        home: Away.fromJson(json["home"]),
        away: Away.fromJson(json["away"]),
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "game_id": gameId,
        "time": time,
        "time_status": timeStatus,
        "league": league.toJson(),
        "home": home.toJson(),
        "away": away.toJson(),
        "score": score,
    };
}

class Away {
    Away({
      required  this.name,
      required  this.id,
        this.imageId,
      required  this.cc,
    });

    String name;
    String id;
    String? imageId;
    String cc;

    factory Away.fromJson(Map<String, dynamic> json) => Away(
        name: json["name"],
        id: json["id"],
        imageId: json["image_id"] == null ? null : json["image_id"],
        cc: json["cc"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image_id": imageId == null ? null : imageId,
        "cc": cc,
    };
}



class GameOdd {
    GameOdd({
      required  this.homeOd,
      required  this.drawOd,
      required  this.awayOd,
    });

    String homeOd;
    String drawOd;
    String awayOd;

    factory GameOdd.fromJson(Map<String, dynamic> json) => GameOdd(
        homeOd: json["home_od"],
        drawOd: json["draw_od"],
        awayOd: json["away_od"],
    );

    Map<String, dynamic> toJson() => {
        "home_od": homeOd,
        "draw_od": drawOd,
        "away_od": awayOd,
    };
}

