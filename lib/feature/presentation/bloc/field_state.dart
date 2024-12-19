import 'package:equatable/equatable.dart';

class FieldState extends Equatable {
  final List<List<int>> field;
  final Map<int, int> placedShips; // Кількість розміщених кораблів
  final Map<int, int> availableShips; // Кількість кораблів, які ще можна розставити
  final List<List<bool>> hoveredCells; // Підсвічені клітинки

  const FieldState({
    required this.field,
    required this.placedShips,
    required this.availableShips,
    required this.hoveredCells,
  });

  // Початковий стан гри
  FieldState.initial()
      : field = List.generate(10, (_) => List.generate(10, (_) => 0)),
        placedShips = {},
        availableShips = {4: 1, 3: 2, 2: 3, 1: 4},
        hoveredCells = List.generate(10, (_) => List.generate(10, (_) => false));

  FieldState copyWith({
    List<List<int>>? field,
    Map<int, int>? placedShips,
    Map<int, int>? availableShips,
    List<List<bool>>? hoveredCells,
  }) {
    return FieldState(
      field: field ?? this.field,
      placedShips: placedShips ?? this.placedShips,
      availableShips: availableShips ?? this.availableShips,
      hoveredCells: hoveredCells ?? this.hoveredCells,
    );
  }

  @override
  List<Object?> get props => [field, placedShips, availableShips, hoveredCells];
}
