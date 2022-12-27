import 'package:dor_selector/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondRoute extends StatelessWidget {
  SecondRoute({super.key});

  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    final PlayersProvider playerProvider = Provider.of<PlayersProvider>(context, listen: true);

    final _w = MediaQuery.of(context).size.width;
    final _h = MediaQuery.of(context).size.height;

    dropdownValue = playerProvider.numWinners;
    return Center(
      child: Hero(
        tag: 'imageHero',
        transitionOnUserGestures: true,
        createRectTween: (lalo, lalo2) {
          return MaterialRectArcTween(begin: lalo, end: lalo2);
        },
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_h / 25)),
          child: Padding(
            padding: EdgeInsets.all(_h / 100),
            child: SizedBox(
              //color: Colors.orange.withOpacity(0.5),
              width: _w * 0.65,
              height: _h * 0.3,
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('CONFIGURACIÓN', style: TextStyle(fontSize: _h / 40), overflow: TextOverflow.ellipsis),
                    const Divider(color: Colors.deepOrangeAccent, thickness: 0.5, indent: 10, endIndent: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text('Número de selecciones:', style: TextStyle(fontSize: _h / 50), overflow: TextOverflow.ellipsis),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: DropdownButton<int>(
                              value: dropdownValue,
                              //icon: Icon(Icons.touch_app_rounded),
                              style: TextStyle(color: Colors.black, fontSize: _h * 0.025),
                              iconSize: _h * 0.04,
                              onChanged: (int? newValue) {
                                playerProvider.numWinners = newValue ?? 1;
                                print(newValue);
                              },
                              items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
