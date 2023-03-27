import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'room_state.dart';

/// cubit responsible for routing between lobby, matchup and game layers
class RoomCubit extends Cubit<RoomState> {
  RoomCubit(this._dataRepository) : super(const RoomState());

  final DataRepository _dataRepository;

  void enterGame() {
    emit(state.copyWith(status: RoomStatus.inGame));
  }

  void enterRoom() {
    emit(state.copyWith(status: RoomStatus.inMathup));
  }

  void leaveRoom() {
    _dataRepository.leaveRoom();
    emit(state.copyWith(status: RoomStatus.inLobby));
  }
}
