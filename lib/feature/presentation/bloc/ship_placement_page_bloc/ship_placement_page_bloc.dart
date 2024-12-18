import 'package:flutter_bloc/flutter_bloc.dart';

import 'ship_placement_page_event.dart';
import 'ship_placement_page_state.dart';

class ShipPlacementPageBloc extends Bloc<ShipPlacementPageEvent, ShipPlacementPageState> {
  ShipPlacementPageBloc(): super(ShipPlacementPageState.initial()) {
    // on<ShipPlacementPageEvent>(_placeShip);
  }
}