import 'package:dor_selector/models/boardpainter_model.dart';
import 'package:dor_selector/providers/players_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TouchPainter extends StatefulWidget {
  const TouchPainter({Key? key}) : super(key: key);

  @override
  State<TouchPainter> createState() => _TouchPainterState();
}

class _TouchPainterState extends State<TouchPainter> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _animationController;

  double value4Winner = 0.0;
  bool winner = false;

  @override
  void initState() {
    super.initState();
    print('TouchPainter - inistState');
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    animation.addListener(() {
      setState(() {});
    });
    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('Builder - TouchPainter');
    final PlayersProvider playerProvider = Provider.of<PlayersProvider>(context, listen: true);

    if (playerProvider.winnerID != 0 && !winner) {
      value4Winner = animation.value;
      _animationController.reset();
      _animationController.duration = const Duration(milliseconds: 2000);
      _animationController.repeat(reverse: true);
      winner = true;
    }
    return CustomPaint(
      painter: BoardPainter(playerProvider, animation.value, value4Winner, MediaQuery.of(context).size.height),
    );
  }
}
