import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:provider/provider.dart';

import 'package:dor_selector/providers/players_provider.dart';
import 'package:dor_selector/providers/ui_provider.dart';
import 'package:dor_selector/pages/menu_page.dart';
import 'package:dor_selector/models/pendrag_model.dart';
import 'package:dor_selector/models/touchdata_model.dart';
import 'package:dor_selector/widgets/touchpainter_widget.dart';
import 'package:dor_selector/widgets/instrucciones_widget.dart';
import 'package:dor_selector/widgets/initGame_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Builder - HomePage');

    //Size of screen
    final _navH = MediaQuery.of(context).padding.bottom;
    final _w = MediaQuery.of(context).size.width;
    final _h = MediaQuery.of(context).size.height;

    final PlayersProvider playerProvider = Provider.of<PlayersProvider>(context, listen: false);
    final UiProvider uiProvider = Provider.of<UiProvider>(context, listen: false);

    //final TimerProvider timerProvider = Provider.of<TimerProvider>(context, listen: false);
    //final List<TouchData> _players = playerProvider.players;
    int _idUnico = 0;
    final List<Color> _colorList = [
      Colors.blueAccent,
      Colors.amberAccent,
      Colors.deepPurpleAccent,
      Colors.cyanAccent,
      Colors.deepOrangeAccent,
      Colors.greenAccent,
      Colors.white,
      Colors.tealAccent,
      Colors.limeAccent,
      Colors.pinkAccent,
    ];
    int _colorID = 0;

    return Scaffold(
      body: Listener(
        onPointerDown: (event) {
          // Id unico del pointer
          _idUnico = event.pointer;

          // Color unico
          if (playerProvider.players.isEmpty) {
            _colorID = Random().nextInt(_colorList.length);
          } else {
            _colorID++;
            if (_colorID > 9) {
              _colorID = 0;
            }
          }
        },
        onPointerUp: (event) {
          // Removemos pointer
          playerProvider.removePlayer(event.pointer);
        },
        onPointerCancel: (event) {
          playerProvider.removeAll();
        },
        child: RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            ImmediateMultiDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<ImmediateMultiDragGestureRecognizer>(
              () => ImmediateMultiDragGestureRecognizer(),
              (ImmediateMultiDragGestureRecognizer instance) {
                instance.onStart = (Offset offset) {
                  if (playerProvider.winnerID == 0 && playerProvider.numPlayers == 0) {
                    //print('Color $_colorID');
                    playerProvider.addPlayer(TouchData(_idUnico, _colorList[_colorID], offset));
                  }
                  return PenDrag((details, idUnico) {
                    //onUpdate
                    playerProvider.newOffset(idUnico, details);
                  }, (idUnico) {
                    //onEnd
                    //playerProvider.removePlayer(idUnico);
                    //if (playerProvider.playerCounter <= 1) {
                    //  playerProvider.stopTimer();
                    //}
                  }, (idUnico) {
                    playerProvider.removeAll();
                  }, _idUnico);
                };
              },
            ),
          },
          child: Selector<PlayersProvider, bool>(
            selector: (_, playerProvider) => playerProvider.players.isEmpty,
            builder: (_, value, __) {
              print('Juegue');
              return Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: value ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(0.5),
                          child: Selector<UiProvider, bool>(
                              selector: (_, uiProvider) => uiProvider.info,
                              builder: (_, value, __) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    value ? const Instrucciones() : const InitGameString(),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    !value
                        ? Selector<PlayersProvider, int>(
                            selector: (_, playerProvider) => playerProvider.secondsCounter,
                            builder: (_, seconds, __) {
                              print('$seconds');
                              if (seconds <= 3 && seconds > 0) {
                                return Center(
                                  child: Text(
                                    '$seconds',
                                    softWrap: true,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })
                        : Container(),

                    !value ? const TouchPainter() : Container(),
                    // Floating Button
                    value
                        ? Positioned(
                            bottom: _h * .05,
                            right: _w * .05,
                            child: Column(
                              children: [
                                FloatingActionButton.small(
                                  onPressed: () {
                                    uiProvider.info = !uiProvider.info;
                                  },
                                  backgroundColor: Colors.blue,
                                  child: const Icon(Icons.question_mark_rounded),
                                ),
                                SizedBox(
                                  height: _h * 0.025,
                                ),
                                Hero(
                                  tag: 'imageHero',
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          transitionDuration: const Duration(milliseconds: 750),
                                          barrierDismissible: true,
                                          barrierColor: Colors.black87,
                                          pageBuilder: (_, __, ___) => SecondRoute(),
                                        ),
                                      );
                                    },
                                    heroTag: null,
                                    backgroundColor: Colors.white,
                                    child: const Icon(
                                      Icons.settings_rounded,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                /*ClipRRect(
                                  borderRadius: BorderRadius.circular(_h),
                                  child: Container(
                                    width: _h * 0.05,
                                    height: _h * 0.05,
                                    color: Colors.blue,
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            uiProvider.info = !uiProvider.info;
                                          },
                                          color: Colors.white,
                                          icon: const Icon(Icons.question_mark_rounded)),
                                    ),
                                  ),
                                ),*/
                                /*GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration: const Duration(milliseconds: 750),
                                        barrierDismissible: true,
                                        barrierColor: Colors.black87,
                                        pageBuilder: (_, __, ___) => SecondRoute(),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'imageHero',
                                    //transitionOnUserGestures: true,
                                    /*createRectTween: (lalo, lalo2) {
                                      return MaterialRectArcTween(begin: lalo, end: lalo2);
                                    },*/
                                    child: Container(
                                      width: _h * 0.075,
                                      height: _h * 0.075,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_h)),
                                      child: const Icon(Icons.settings_rounded, color: Colors.red),
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            },
            //shouldRebuild: (previous, next) => true,
          ),
        ),
      ),
    );
  }

  /*void startTimer(BuildContext context, TimerProvider timerProvider) {
    print('Timer - Start');
    timerProvider.timepo = Timer(const Duration(seconds: 3), () => print('Timer finished'));
  }

  void addTime() {
    print('Timer - AddTime');
  }

  void stopTimer(TimerProvider timerProvider) {
    print('Timer - STOP');
    timerProvider.timepo?.cancel();
  }*/
}
