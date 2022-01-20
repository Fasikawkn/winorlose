import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:winorlose/src/controller/game_match_provider.dart';
import 'package:winorlose/src/models/api/api_response.dart';
import 'package:winorlose/src/models/match_model.dart';
import 'package:winorlose/src/views/widgets/animated_file_2.dart';
import 'package:winorlose/src/views/widgets/correct_alert.dart';
import 'package:winorlose/translations/locale_keys.g.dart';
import 'package:winorlose/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GameMatchModel>(context, listen: false).getCompletedMatch();
    });
  }

  bool _play = false;
  double _position = 0;
  Timer? _timer;
  String? _child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<GameMatchModel>(builder: (context, model, child) {
        debugPrint("response is ${model.response.status}");
        debugPrint("winner response is ${model.winnedResponse.status}");
        if (model.response.status == Status.initial ||
            model.response.status == Status.loading 
          ) {
          return const Center(
            child: CircularProgressIndicator(
              color: kYellowColor,
            ),
          );
        } else if (model.response.status == Status.completed ) {
          GameMatch _gameMatch = model.response.data;
          String _date = CustomFunctions.getDate(_gameMatch.time);
          String _time = CustomFunctions.getTime(_gameMatch.time);
          List<double> score =
              _gameMatch.score.split(':').map((e) => double.parse(e)).toList();
          Map<String, dynamic> _resultSet = {
            'Front': score[0],
            'Back': score[1],
          };
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: size.height * 0.08,),
               Container(
                 padding: const EdgeInsets.symmetric(
                   horizontal: 20.0,
                   vertical: 30.0,
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   
                   children: [
                      Text(
                       LocaleKeys.who_has_won_label_text.tr(),
                       style: const TextStyle(
                         color: kYellowColor,
                         fontSize: 30.0,
                         fontWeight: FontWeight.w900,
                       ),
                     ),
                     const SizedBox(
                       height: 40.0,
                     ),
                     FutureBuilder<GameOdd>(
                         future: model.getOdd(_gameMatch.gameId),
                         builder: (context, snapshot) {
                           return Row(
                             mainAxisAlignment:
                                 MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               _buildOdd(
                                 snapshot.hasData
                                     ? Text(
                                         snapshot.data!.homeOd,
                                         style: const TextStyle(
                                           fontSize: 18.0,
                                           fontWeight: FontWeight.w600,
                                         ),
                                       )
                                     : const SpinKitThreeBounce(
                                         color: kYellowColor,
                                         size: 12.0,
                                       ),
                               ),
                               Column(
                                 children: [
                                   _buildOdd(
                                     snapshot.hasData
                                         ? Text(
                                             snapshot.data!.awayOd,
                                             style: const TextStyle(
                                               fontSize: 18.0,
                                               fontWeight: FontWeight.w600,
                                             ),
                                           )
                                         : const SpinKitThreeBounce(
                                             color: kYellowColor,
                                             size: 12.0,
                                           ),
                                   ),
                                   const SizedBox(
                                     height: 5.0,
                                   ),
                                    Text(
                                     LocaleKeys.drawLabelText.tr(),
                                     style: const TextStyle(
                                       color: Colors.grey,
                                     ),
                                   )
                                 ],
                               ),
                               _buildOdd(
                                 snapshot.hasData
                                     ? Text(
                                         snapshot.data!.awayOd,
                                         style: const TextStyle(
                                           fontSize: 18.0,
                                           fontWeight: FontWeight.w600,
                                         ),
                                       )
                                     : const SpinKitThreeBounce(
                                         color: kYellowColor,
                                         size: 12.0,
                                       ),
                               ),
                             ],
                           );
                         }),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Column(
                           children: [
                             CachedNetworkImage(
                               imageUrl:
                                   'https://spoyer.ru/api/team_img/soccer/${_gameMatch.home.id}.png',
                               imageBuilder: (context, imageProvider) =>
                                   Container(
                                 width: 100.0,
                                 height: 100.0,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                     image: imageProvider,
                                   ),
                                 ),
                               ),
                               placeholder: (context, url) =>
                                   const SpinKitCircle(
                                 color: kYellowColor,
                                 size: 50.0,
                               ),
                               errorWidget: (context, url, err) => Image.asset(
                                 'assets/images/team_image.png',
                                 width: 100,
                               ),
                             ),
                              const SizedBox(height: 10.0,),
                             ConstrainedBox(
                               constraints: const BoxConstraints(maxWidth: 100),
                               child: Text(
                                 getTeamTitleName(_gameMatch.home.name), 
                                 style: const TextStyle(
                                   color: kYellowColor, 
                                 fontSize: 16.0, fontWeight: FontWeight.w500, 
                                 ),
                                 ),
                                 )
                           ],
                         ),
                          Text(
                           LocaleKeys.orLabelTextLabelText.tr(),
                           style:const TextStyle(
                             color: kYellowColor,
                             fontSize: 30.0,
                             fontWeight: FontWeight.w900,
                           ),
                         ),
                         Column(
                           children: [
                             CachedNetworkImage(
                               imageUrl:
                                   'https://spoyer.ru/api/team_img/soccer/${_gameMatch.away.id}.png',
                               imageBuilder: (context, imageProvider) =>
                                   Container(
                                 width: 100.0,
                                 height: 100.0,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                     image: imageProvider,
                                   ),
                                 ),
                               ),
                               placeholder: (context, url) =>
                                   const SpinKitCircle(
                                 color: kYellowColor,
                                 size: 50.0,
                               ),
                               errorWidget: (context, url, err) => Image.asset(
                                 'assets/images/team_image.png',
                                 width: 100.0,
                               ),
                             ),
                            const SizedBox(height: 10.0,),
                             ConstrainedBox(
                               constraints: const BoxConstraints(maxWidth: 100),
                               child: Text(
                                 getTeamTitleName(_gameMatch.away.name), 
                                 style: const TextStyle(color: kYellowColor, fontSize: 16.0, fontWeight: FontWeight.w500, ),
                                 ),)
                           ],
                         ),
                       ],
                     ),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SvgPicture.asset(
                           'assets/images/Frame5.svg',
                         ),
                         Text(
                           '${LocaleKeys.theMatchLabelText.tr()} \n$_date \n${LocaleKeys.atLabelText.tr()} $_time',
                         ),
                         SvgPicture.asset(
                           'assets/images/Frame6.svg',
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               Stack(children: [
                 SizedBox(
                   // margin: const EdgeInsets.only(top: 100),
                   height: size.height * 0.5,
                   width: size.width,
                   child: CustomPaint(
                     painter: CurvePainter(),
                   ),
                 ),
                 Align(
                   alignment: const Alignment(0, 0.5),
                   child: _play
                       ? Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             CardWidget(
                               childCallBack: (child) async {
                                 debugPrint("$score");
                                await Future.delayed(const Duration(milliseconds: 500));
                                 if (child) {
                                   print("Front is called Back");
                                   if (score[1] > score[0]) {
                                     debugPrint('Right won');
                                     showDialog(
                                       
                                         context: context,
                                         barrierDismissible: false,
                                         builder: (context) =>
                                             CorrectAlert(
                                               _gameMatch,
                                               isCorrect: true,
                                             ),);
                                   } else {
                                     debugPrint('Left Won');
                                     showDialog(
                                       barrierDismissible: false,
                                         context: context,
                                         builder: (context) =>
                                             CorrectAlert(
                                               _gameMatch,
                                               isCorrect: false,
                                             ));
                                   }
                                 } else {
                                   debugPrint('Back is Called');
                                   if (score[0] > score[1]) {
                                     debugPrint('left won');
                                     showDialog(
                                       barrierDismissible: false,
                                         context: context,
                                         builder: (context) =>
                                             CorrectAlert(
                                               _gameMatch,
                                               isCorrect: true,
                                             ));
                                   } else {
                                     debugPrint('Right won');
                                     showDialog(
                                         context: context,
                                         barrierDismissible: false,
                                         builder: (context) =>
                                             CorrectAlert(
                                               _gameMatch,
                                               isCorrect: false,
                                             ),);
                                   }
                                 }
                               },
                             ),
                              Text(
                               LocaleKeys.stopTheChipLabelText.tr(),
                               style: const TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 18,
                               ),
                             )
                           ],
                         )
                       : GestureDetector(
                           onTap: () {
                             setState(() {
                               _play = true;
                             });
                           },
                           child: Container(
                             height: 200.0,
                             width: 200.0,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               gradient: const LinearGradient(
                                 colors: [
                                   Color(0xffF3903C),
                                   Color(0xffEE7A3B),
                                 ],
                               ),
                               border: Border.all(
                                 color: kYellowColor,
                                 width: 2.0,
                               ),
                             ),
                             child:  Center(
                               child: Text(
                                 LocaleKeys.guessWhoWonLabelText.tr(),
                                 textAlign: TextAlign.center,
                                 style: const TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.w900,
                                   fontSize: 25.0,
                                 ),
                               ),
                             ),
                           ),
                         ),
                 ),
               ],)
                 
                  ],
                ),
            ),
          );
        } else {
          return Center(
            child: Text(model.response.message!),
          );
        }
      }),
    );
  }

  Container _buildOdd(Widget odd) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.3,
            offset: Offset(
              3,
              3,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(colors: [
          Colors.grey,
          Colors.white,
        ], begin: Alignment.topRight),
      ),
      child: odd,
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(
      0,
      size.height * 0.2,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
       120,
      size.width * 0.5,
      120,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      120,
      size.width * 1.0,
      size.height * 0.2,
    );
    path.lineTo(
      size.width,
      size.height,
    );
    path.lineTo(
      0,
      size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
