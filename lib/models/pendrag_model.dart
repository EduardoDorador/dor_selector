import 'package:flutter/gestures.dart';

class PenDrag implements Drag {
  final Function onUpdate;
  final Function onEnd;
  final Function onCancel;
  final int idUnico;

  PenDrag(this.onUpdate, this.onEnd, this.onCancel, this.idUnico);

  @override
  void cancel() {
    onCancel(idUnico);
  }

  @override
  void end(DragEndDetails details) {
    onEnd(idUnico);
  }

  @override
  void update(DragUpdateDetails details) {
    onUpdate(details.localPosition, idUnico);
  }
}
