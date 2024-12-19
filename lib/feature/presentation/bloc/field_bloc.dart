import 'package:flutter_bloc/flutter_bloc.dart';
import 'field_event.dart';
import 'field_state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc() : super(FieldState.initial()) {
    on<PlaceShipEvent>(_placeShip);
    on<HoverShipEvent>(_hoverShip);
    on<ClearHoverEvent>(_clearHover);
  }

  void _placeShip(PlaceShipEvent event, Emitter<FieldState> emit) {
    final newField = List.generate(10, (i) => [...state.field[i]]);
    final newPlacedShips = Map<int, int>.from(state.placedShips);
    final newAvailableShips = Map<int, int>.from(state.availableShips);

    if (_canPlaceShip(newField, event.x, event.y, event.length, event.horizontal)) {
      final currentCount = newPlacedShips[event.length] ?? 0;
      final availableCount = newAvailableShips[event.length] ?? 0;

      if (availableCount > 0) {
        // Розміщуємо корабель
        for (int i = 0; i < event.length; i++) {
          final nx = event.horizontal ? event.x : event.x + i;
          final ny = event.horizontal ? event.y + i : event.y;
          newField[nx][ny] = 1;
        }

        newPlacedShips[event.length] = currentCount + 1;
        newAvailableShips[event.length] = availableCount - 1;

        emit(state.copyWith(
          field: newField,
          placedShips: newPlacedShips,
          availableShips: newAvailableShips,
          hoveredCells: List.generate(10, (_) => List.generate(10, (_) => false)),
        ));
      }
    }
  }

  void _hoverShip(HoverShipEvent event, Emitter<FieldState> emit) {
    final hoveredCells = List.generate(10, (_) => List.generate(10, (_) => false));
    final canPlace = _canPlaceShip(state.field, event.x, event.y, event.length, event.horizontal);

    for (int i = 0; i < event.length; i++) {
      final nx = event.horizontal ? event.x : event.x + i;
      final ny = event.horizontal ? event.y + i : event.y;

      if (nx >= 0 && ny >= 0 && nx < 10 && ny < 10) {
        hoveredCells[nx][ny] = true;
      }
    }

    emit(state.copyWith(
      hoveredCells: hoveredCells,
    ));
  }

  void _clearHover(ClearHoverEvent event, Emitter<FieldState> emit) {
    emit(state.copyWith(
      hoveredCells: List.generate(10, (_) => List.generate(10, (_) => false)),
    ));
  }

  bool _canPlaceShip(List<List<int>> field, int x, int y, int length, bool horizontal) {
    for (int i = 0; i < length; i++) {
      final nx = horizontal ? x : x + i;
      final ny = horizontal ? y + i : y;

      // Перевіряємо вихід за межі поля
      if (nx < 0 || ny < 0 || nx >= 10 || ny >= 10) {
        return false;
      }

      // Перевіряємо, чи клітинка зайнята
      if (field[nx][ny] == 1) {
        return false;
      }
    }
    return true;
  }
}
