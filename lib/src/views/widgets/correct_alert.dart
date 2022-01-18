import 'package:flutter/material.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/views/screens/winorlose_detail.dart';
import 'package:winorlose/src/views/screens/winorlose_home_page.dart';
import 'package:winorlose/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CorrectAlert extends StatelessWidget {
  const CorrectAlert(this.gameMatch, {required this.isCorrect, Key? key})
      : super(key: key);
  final GameMatch gameMatch;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      // content: const Text('You are \nright!'),
      alignment: Alignment.center,

      title: Center(
          child: Text(
        isCorrect
            ? LocaleKeys.youAreRightLabelText.tr()
            : LocaleKeys.youAreLoseLabelText.tr(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
        textAlign: TextAlign.start,
      )),
      actions: [
        Center(
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () async {
              Navigator.of(context).pop();
              if (isCorrect) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      gameMatch: gameMatch,
                    ),
                  ),
                );
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (context) => false);
              }
            },
            child: Text(
              LocaleKeys.lookResultLabelText.tr(),  
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
