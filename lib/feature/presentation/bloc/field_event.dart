import 'package:equatable/equatable.dart';

abstract class FieldEvent extends Equatable {
  const FieldEvent();

  @override
  List<Object?> get props => [];
}

class PlaceShipEvent extends FieldEvent {
  final int x;
  final int y;
  final int length;
  final bool horizontal;

  PlaceShipEvent(this.x, this.y, this.length, this.horizontal);

  @override
  List<Object?> get props => [x, y, length, horizontal];
}

class HoverShipEvent extends FieldEvent {
  final int x;
  final int y;
  final int length;
  final bool horizontal;

  const HoverShipEvent(this.x, this.y, this.length, this.horizontal);

  @override
  List<Object?> get props => [x, y, length, horizontal];
}

class ClearHoverEvent extends FieldEvent {}
