// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "who_has_won_label_text": "WHO HAS WON?",
  "orLabelTextLabelText": "OR",
  "drawLabelText": "DRAW",
  "atLabelText": "в",
  "theMatchLabelText": "The match \ntake place on",
  "guessWhoWonLabelText": "Guess\n Who Won",
  "stopTheChipLabelText": "Stop the chip",
  "youAreLoseLabelText": "You are\n lose!",
  "lookResultLabelText": "Look Result!",
  "youAreRightLabelText": "You are\n right",
  "hasWonLabelText": "HAS WON!",
  "attacksLabelText": "Attacks",
  "offTargetLabelText": "Off target",
  "onTargetLabelText": "On Target",
  "cornersLabelText": "Corners",
  "yellowCardLabelText": "Yellow cards",
  "redCardsLabelText": "Red Cards",
  "nextLabelText": "NEXT"
};
static const Map<String,dynamic> ru = {
  "who_has_won_label_text": "Кто победил?",
  "orLabelTextLabelText": "ИЛИ",
  "drawLabelText": "ничья",
  "theMatchTakeLabelText": "Матч состоялся",
  "atLabelText": "в",
  "guessWhoWonLabelText": "Угадай кто победил",
  "stopTheChipLabelText": "Останови фишку",
  "youAreLoseLabelText": "Ты не угадал!",
  "lookResultLabelText": "Смотреть результат",
  "youAreRightLabelText": "Ты не угадал!",
  "hasWonLabelText": "победил!",
  "attacksLabelText": "Атаки",
  "offTargetLabelText": "Вне цели",
  "onTargetLabelText": "В цель",
  "cornersLabelText": "Углы",
  "yellowCardLabelText": "Желтые карточки",
  "redCardsLabelText": "Красные карточки",
  "nextLabelText": "Следующий"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
