import 'package:equatable/equatable.dart';
import 'package:quizapp/models/quiz_model.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<GetQuizEvent>(_onGetQuizEvent);
  }

  void _onGetQuizEvent(GetQuizEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoadingState());
    try {
      final quizList = await QuizService.getQuiz();
      emit(QuizLoadedState(quizList: quizList));
    } catch (e) {
      emit(QuizErrorState(errorMessage: e.toString()));
    }
  }
}
