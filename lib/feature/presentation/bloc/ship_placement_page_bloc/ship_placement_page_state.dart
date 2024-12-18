import 'package:equatable/equatable.dart';

class ShipPlacementPageState extends Equatable {
  final List<List<int>> field;

  const ShipPlacementPageState(this.field);

  ShipPlacementPageState.initial()
      : field = List.generate(10, (_) => List.generate(10, (_) => 0));

  ShipPlacementPageState copyWith({List<List<int>>? field}) {
    return ShipPlacementPageState(field ?? this.field);
  }

  @override
  List<Object?> get props => [field];
}