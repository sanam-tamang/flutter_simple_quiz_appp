// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoadedState extends QuizState {
  final List<QuizModel> quizList;
  const QuizLoadedState({
    required this.quizList,
  });

  @override
  List<Object> get props => [quizList];
}

class QuizErrorState extends QuizState {
  final String errorMessage;
  const QuizErrorState({
    required this.errorMessage,
  });
   @override
  List<Object> get props => [errorMessage];
}


class QuizLoadingState extends QuizState{}