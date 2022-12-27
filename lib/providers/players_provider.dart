import 'dart:async';
import 'dart:math';

import 'package:dor_selector/models/touchdata_model.dart';
import 'package:flutter/material.dart';

class PlayersProvider extends ChangeNotifier {
  List<TouchData> _players = []; // Datos de Jugadores
  List<TouchData> _playersEND = []; // Datos de Jugadores

  Timer? _timer; // Timer
  int _secondsCounter = 0; // Contador de Segundos

  int _numWinners = 1; // Número de ganadores
  int _winnerID = 0; // ID del ganador - 1 jugador
  int _numPlayers = 0; // Número de jugadores - 2 o mas jugadores
  //bool _isEmpty = true;

  // Agregar Jugador
  void addPlayer(TouchData player) {
    _players.add(player);
    if (_players.length > _numWinners) {
      stopTimer();
      startTimer();
    }
    //_isEmpty = players.isEmpty;
    notifyListeners();
  }

  void removePlayer(int idUnico) {
    if (_winnerID <= 0 && _numPlayers <= 0) {
      _players.removeWhere((element) => element.idUnico == idUnico);
      _winnerID = 0;
      _numPlayers = 0;
      stopTimer();
      if (_players.length > _numWinners) {
        stopTimer();
        startTimer();
      }
      // _isEmpty = players.isEmpty;
    } else if (_numWinners >= 1) {
      _playersEND.removeWhere((element) => element.idUnico == idUnico);
      if (_playersEND.isEmpty) {
        Timer(const Duration(milliseconds: 2500), () => removeAll());
      }
    } else {}
    notifyListeners();
  }

  void removeAll() {
    _players.clear();
    _playersEND.clear();
    _winnerID = 0;
    _numPlayers = 0;
    //_isEmpty = players.isEmpty;
    notifyListeners();
  }

  void newOffset(int idUnico, Offset offset) {
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].idUnico == idUnico) {
        _players[i].offset = offset;
      }
    }
  }

  set numWinners(int value) {
    _numWinners = value;
    notifyListeners();
  }

  //***** Timer
  void startTimer() {
    print('Timer - Start');
    _secondsCounter = 4;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    _secondsCounter--;
    // Se termina el juego
    if (_secondsCounter <= 0) {
      stopTimer();
      _playersEND = List.from(_players);
      if (_numWinners == 1) {
        _winnerID = _players[Random().nextInt(_players.length)].idUnico;
        //print('Winner $_winner');
      } else {
        _numPlayers = _players.length;
        for (int i = 0; i < _numPlayers - _numWinners; i++) {
          _players.removeAt(Random().nextInt(_players.length));
          //print(winners.length);
        }
      }
      _secondsCounter = 4;
    }
    notifyListeners();
  }

  void stopTimer() {
    //print('Timer - STOP');
    _timer?.cancel();
    _secondsCounter = 4;
  }

  //***** Getters

  int get winnerID {
    return _winnerID;
  }

  /*bool get isEmpty {
    return _isEmpty;
  }*/

  int get numWinners {
    return _numWinners;
  }

  int get secondsCounter {
    return _secondsCounter;
  }

  int get numPlayers {
    return _numPlayers;
  }

  List<TouchData> get players {
    return _players;
  }
}
