import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dor_selector/providers/players_provider.dart';

class Instrucciones extends StatelessWidget {
  const Instrucciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayersProvider playerProvider = Provider.of<PlayersProvider>(context, listen: false);

    final _w = MediaQuery.of(context).size.width;
    final _h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(9),
          },
          children: [
            TableRow(
              children: [
                Text(
                  '1 -',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _h * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Todos los jugadores coloquen un dedo en la pantalla.',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _h * 0.025,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(children: [SizedBox(height: _h * 0.04), SizedBox(height: _h * 0.04)]),
            TableRow(
              children: [
                Text(
                  '2 -',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _h * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Selector<PlayersProvider, int>(
                  selector: (_, playerProvider) => playerProvider.numWinners,
                  builder: (_, value, __) {
                    print('jugadores');
                    return value == 1
                        ? Text(
                            'El juego inicia automáticamente, y 3 segundos después, se seleccionará al ganador aleatoriamente.',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _h * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'El juego inicia automáticamente, y 3 segundos después, se seleccionarán ${playerProvider.numWinners} ganadores aleatoriamente.',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _h * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          );
                  },
                ),
              ],
            ),
            TableRow(children: [SizedBox(height: _h * 0.04), SizedBox(height: _h * 0.04)]),
            TableRow(
              children: [
                Text(
                  '3 -',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _h * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Para reiniciar el juego, retire todos los dedos de la pantalla.',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _h * 0.025,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: _h * 0.08),
        Text(
          '⚙️ - Puedes cambiar el número de ganadores en el menú de configuración.',
          softWrap: true,
          style: TextStyle(
            color: Colors.orange.shade200,
            fontSize: _h * 0.02,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    /*Column(
      children: [
        Text(
          '1 - Todos los jugadores coloquen un dedo en la pantalla.',
          softWrap: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: _h * 0.03,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _h * 0.04),
        Selector<PlayersProvider, int>(
            selector: (_, playerProvider) => playerProvider.numWinners,
            builder: (_, value, __) {
              print('jugadores');
              return value == 1
                  ? Text(
                      '2 - El juego inicia automáticamente, y 3 segundos después, se seleccionará al ganador aleatoriamente.',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _h * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      '2 - El juego inicia automáticamente, y 3 segundos después, se seleccionarán ${playerProvider.numWinners} ganadores aleatoriamente.',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _h * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    );
            }),
        SizedBox(height: _h * 0.04),
        Text(
          '3 - Para reiniciar el juego, retire todos los dedos de la pantalla.',
          softWrap: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: _h * 0.03,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _h * 0.08),
        Text(
          '⚙️ - Puedes cambiar el número de ganadores en el menú de configuración.',
          softWrap: true,
          style: TextStyle(
            color: Colors.orange.shade200,
            fontSize: _h * 0.02,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );*/
  }
}
