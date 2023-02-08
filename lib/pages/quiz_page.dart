import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/quiz_bloc/quiz_bloc.dart';
import '../widgets/quiz_tiles.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    context.read<QuizBloc>().add(GetQuizEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is QuizLoadedState) {
              return QuizTile(quizList: state.quizList);
            } else if (state is QuizErrorState) {
              return Text(state.errorMessage);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
