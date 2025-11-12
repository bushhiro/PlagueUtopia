import 'package:flutter_bloc/flutter_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState.initial()) {
    on<UpdateDoctorPosition>(_onUpdateDoctorPosition);
    on<UpdateSubordinatePosition>(_onUpdateSubordinatePosition);
  }

  void _onUpdateDoctorPosition(UpdateDoctorPosition event, Emitter<MapState> emit) {
    final updatedDoctors = state.doctors.map((d) {
      if (d.id == event.doctor.id) {
        d.position = event.newLocation;
      }
      return d;
    }).toList();
    emit(state.copyWith(doctors: updatedDoctors));
  }

  void _onUpdateSubordinatePosition(UpdateSubordinatePosition event, Emitter<MapState> emit) {
    final updatedSubordinates = state.subordinates.map((s) {
      if (s.id == event.subordinate.id) {
        s.position = event.newLocation;
      }
      return s;
    }).toList();
    emit(state.copyWith(subordinates: updatedSubordinates));
  }
}