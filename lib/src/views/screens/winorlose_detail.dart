import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:winorlose/src/controller/game_match_provider.dart';
import 'package:winorlose/src/models/api/api_response.dart';
import 'package:winorlose/src/models/match_event_model.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/views/screens/winorlose_home_page.dart';
import 'package:winorlose/translations/locale_keys.g.dart';
import 'package:winorlose/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.gameMatch,
  }) : super(key: key);

  final GameMatch gameMatch;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getGameMatchEvent();
    });
  }

  _getGameMatchEvent() async {
    await Provider.of<GameMatchModel>(context, listen: false)
        .getGameMatchevent(widget.gameMatch.gameId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _score =
        widget.gameMatch.score.split(':').map((e) => int.parse(e)).toList();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${_score[0] > _score[1] ? widget.gameMatch.home.name.toUpperCase() :
                   widget.gameMatch.away.name.toUpperCase()} ${LocaleKeys.hasWonLabelText.tr()}",
                  style: const TextStyle(
                      color: kYellowColor,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900),
                ),
                Container(
                  width: size.width,
                  height: 200,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Subtract.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kYellowColor,
                        width: 1,
                      ),
                      gradient: const LinearGradient(
                        colors: [Colors.grey, Colors.white, kYellowColor],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://spoyer.ru/api/team_img/football/${widget.gameMatch.home.id}.png',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: imageProvider)),
                          ),
                          placeholder: (context, url) =>
                              const SpinKitThreeBounce(
                            color: kYellowColor,
                            size: 20.0,
                          ),
                          errorWidget: (context, url, err) => Image.asset(
                            'assets/images/team_image.png',
                            width: 100.0,
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              'https://spoyer.ru/api/team_img/football/${widget.gameMatch.home.id}.png',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: imageProvider)),
                          ),
                          placeholder: (context, url) =>
                              const SpinKitThreeBounce(
                            color: kYellowColor,
                            size: 20.0,
                          ),
                          errorWidget: (context, url, err) => Image.asset(
                            'assets/images/team_image.png',
                            width: 100.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 100,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/subtract_middle.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kYellowColor,
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${_score[0]}',
                          style: const TextStyle(
                            color: kYellowColor,
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '${_score[1]}',
                          style: const TextStyle(
                            color: kYellowColor,
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 300,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/subtract_bottom.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kYellowColor,
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Consumer<GameMatchModel>(
                          builder: (context, model, child) {
                        if (model.eventResponse.status == Status.initial ||
                            model.eventResponse.status == Status.loading) {
                          return const Center(
                            child: SpinKitFadingCircle(
                              color: kYellowColor,
                              size: 40.0,
                            ),
                          );
                        } else if (model.eventResponse.status ==
                            Status.completed) {
                          GameEvent _gameEvent = model.eventResponse.data;
                          print(model.eventResponse.data);
                          return Column(children: [
                            AssistResult(
                                leftText: _gameEvent.attacks[0],
                                middleText: LocaleKeys.attacksLabelText.tr(),
                                rightText: _gameEvent.attacks[1]),
                            AssistResult(
                                leftText: _gameEvent.offTarget[0],
                                middleText: LocaleKeys.offTargetLabelText.tr(),
                                rightText: _gameEvent.offTarget[1]),
                            AssistResult(
                                leftText: _gameEvent.onTarget[0],
                                middleText: LocaleKeys.onTargetLabelText.tr(),
                                rightText: _gameEvent.onTarget[1]),
                            AssistResult(
                                leftText: _gameEvent.corners[0],
                                middleText: LocaleKeys.onTargetLabelText.tr(),
                                rightText: _gameEvent.corners[1]),
                            AssistResult(
                                leftText: _gameEvent.yellowcards[0],
                                middleText: LocaleKeys.yellowCardLabelText.tr(),
                                rightText: _gameEvent.yellowcards[1]),
                            AssistResult(
                                leftText: _gameEvent.redcards[0],
                                middleText: LocaleKeys.redCardsLabelText.tr(),
                                rightText: _gameEvent.redcards[1]),
                          ]);
                        } else {
                          print("Error ${model.eventResponse.status}");
                          return Center(
                            child: Text(model.eventResponse.message!),
                          );
                        }
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  },
                  style: TextButton.styleFrom(backgroundColor: kYellowColor),
                  child: Text(
                    LocaleKeys.nextLabelText.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssistResult extends StatelessWidget {
  const AssistResult(
      {Key? key,
      required this.leftText,
      required this.middleText,
      required this.rightText})
      : super(key: key);
  final String leftText;
  final String middleText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
              color: kYellowColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            middleText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            rightText,
            style: const TextStyle(
              color: kYellowColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
