import 'dart:math';

import 'package:dor_selector/providers/players_provider.dart';
import 'package:flutter/material.dart';

class BoardPainter extends CustomPainter {
  final PlayersProvider playersProvider;
  final double animationValue;
  final double animation4Winner;
  final double safeSize;

  BoardPainter(this.playersProvider, this.animationValue, this.animation4Winner, this.safeSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Un Ganador
    if (playersProvider.numWinners == 1) {
      for (int i = 0; i < playersProvider.players.length; i++) {
        if (playersProvider.winnerID == playersProvider.players[i].idUnico) {
          canvas.drawCircle(
              playersProvider.players[i].offset,
              safeSize * 0.025 + (animationValue * safeSize * 0.75),
              Paint()
                ..isAntiAlias = true
                ..strokeWidth = 10.0
                ..color = playersProvider.players[i].colorUnico
                ..style = PaintingStyle.fill);
          canvas.drawCircle(
              playersProvider.players[i].offset,
              (safeSize * 0.05),
              Paint()
                ..isAntiAlias = true
                ..strokeWidth = safeSize * 0.015
                ..color = Colors.black
                ..style = PaintingStyle.fill);
        }
      }
      for (int i = 0; i < playersProvider.players.length; i++) {
        if (playersProvider.winnerID != playersProvider.players[i].idUnico) {
          for (int value = 3; value >= 0; value--) {
            //print('color - $value ${1 - ((value + animationValue) / 4).clamp(0.0, 1.0)}');
            canvas.drawCircle(
                playersProvider.players[i].offset,
                //playersProvider.winner == 0 ? (safeSize * 0.05) + (animationValue * safeSize * 0.025) : (safeSize * 0.05) + (animation4Winner * safeSize * 0.025),
                sqrt(((safeSize * 0.08) * (safeSize * 0.08)) * (value + animationValue) / 4),
                Paint()
                  ..isAntiAlias = true
                  ..strokeWidth = safeSize * 0.012
                  ..color =
                      playersProvider.winnerID == 0 ? playersProvider.players[i].colorUnico.withOpacity(1 - ((value + animationValue) / 4).clamp(0.0, 1.0)) : playersProvider.players[i].colorUnico
                  ..style = playersProvider.winnerID == 0 ? PaintingStyle.stroke : PaintingStyle.fill);
          }
        }
      }
    }
    // Dos o mas ganadores
    if (playersProvider.numWinners > 1) {
      if (playersProvider.numPlayers > 0) {
        for (int i = 0; i < playersProvider.players.length - 1; i++) {
          canvas.drawLine(
              playersProvider.players[i].offset,
              playersProvider.players[i + 1].offset,
              Paint()
                ..isAntiAlias = true
                ..strokeWidth = safeSize * 0.005
                ..color = Colors.white
                ..style = PaintingStyle.stroke);
        }
      }

      for (int i = 0; i < playersProvider.players.length; i++) {
        if (playersProvider.winnerID != playersProvider.players[i].idUnico) {
          for (int value = 3; value >= 0; value--) {
            //print('color - $value ${1 - ((value + animationValue) / 4).clamp(0.0, 1.0)}');
            canvas.drawCircle(
                playersProvider.players[i].offset,
                //playersProvider.winner == 0 ? (safeSize * 0.05) + (animationValue * safeSize * 0.025) : (safeSize * 0.05) + (animation4Winner * safeSize * 0.025),
                sqrt(((safeSize * 0.10) * (safeSize * 0.10)) * (value + animationValue) / 4),
                Paint()
                  ..isAntiAlias = true
                  ..strokeWidth = safeSize * 0.015
                  ..color = playersProvider.players[i].colorUnico.withOpacity(1 - ((value + animationValue) / 4).clamp(0.0, 1.0))
                  ..style = playersProvider.numPlayers == 0 ? PaintingStyle.stroke : PaintingStyle.fill);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
