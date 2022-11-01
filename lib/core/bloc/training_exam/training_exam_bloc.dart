import 'package:flutter_bloc/flutter_bloc.dart';
part 'training_exam_event.dart';
part 'training_exam_state.dart';

class TrainingTestBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingTestBloc() : super(TrainingStates()) {
    on<TrainingEvent>((event, emit) => _answer(event, emit));
  }

  void _answer(TrainingEvent event, Emitter<TrainingState> emit) async {
    emit(AnswerState());
  }
}
