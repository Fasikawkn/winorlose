import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:winorlose/src/controller/game_match_provider.dart';
import 'package:winorlose/src/models/services/data_provider/match_data_provider.dart';
import 'package:winorlose/src/models/services/respository/match_respository.dart';
import 'package:winorlose/src/views/screens/winorlose_splash_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: "assets/translations",
      startLocale:  Locale(Platform.localeName.split('_')[0]),
      fallbackLocale: const Locale('en'),
      child: const WinOrLose(),
    ),
  );
}

class WinOrLose extends StatelessWidget {
  const WinOrLose({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => GameMatchModel(
                  repository: MatchRepository(
                    dataProvider: MatchDataProvider(
                      httpClient: http.Client(),
                    ),
                  ),
                ),),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(),
        home: const SplashScreen(),
      ),
    );
  }
}
