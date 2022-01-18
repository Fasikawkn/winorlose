class GameEvent {
  GameEvent({
    required this.attacks,
    required this.corners,
    required this.offTarget,
    required this.onTarget,
    required this.redcards,
    required this.yellowcards,
  });

  List<String> attacks;
  List<String> corners;
  List<String> offTarget;
  List<String> onTarget;
  List<String> redcards;
  List<String> yellowcards;

  factory GameEvent.fromJson(Map<String, dynamic> json) => GameEvent(
        attacks: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["attacks"].map((x) => x)),
        corners: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["corners"].map((x) => x)),
        offTarget: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["off_target"].map((x) => x)),
        onTarget: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["on_target"].map((x) => x)),
        redcards: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["redcards"].map((x) => x)),
        yellowcards: json['attacks'] == null
            ? ["N/A", "N/A"]
            : List<String>.from(json["yellowcards"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "attacks": List<dynamic>.from(attacks.map((x) => x)),
        "corners": List<dynamic>.from(corners.map((x) => x)),
        "off_target": List<dynamic>.from(offTarget.map((x) => x)),
        "on_target": List<dynamic>.from(onTarget.map((x) => x)),
        "redcards": List<dynamic>.from(redcards.map((x) => x)),
        "yellowcards": List<dynamic>.from(yellowcards.map((x) => x)),
      };
}
