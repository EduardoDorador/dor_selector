import 'package:flutter/material.dart';

import 'package:dor_selector/providers/players_provider.dart';
import 'package:provider/provider.dart';

class InitGameString extends StatelessWidget {
  const InitGameString({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayersProvider playerProvider = Provider.of<PlayersProvider>(context, listen: false);
    final _h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          'Todos los jugadores coloquen un dedo en la pantalla para comenzar.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: _h * 0.02,
          ),
          textAlign: TextAlign.center,
          //textAlign: TextAlign.center,
        ),
        SizedBox(height: _h * 0.04),
        Selector<PlayersProvider, int>(
          selector: (_, playerProvider) => playerProvider.numWinners,
          builder: (_, value, __) {
            print('jugadores');
            return Text(
              value == 1 ? '🏆 - 1 Ganador' : '🏆 - $value Ganadores',
              softWrap: true,
              style: TextStyle(
                color: Colors.orange.shade200,
                fontSize: _h * 0.015,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ],
    );
  }
}
