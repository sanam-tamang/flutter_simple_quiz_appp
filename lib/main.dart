import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/pages/quiz_page.dart';
import 'package:quizapp/services/quiz_service.dart';

import 'blocs/quiz_bloc/quiz_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => QuizService(),
      child: BlocProvider(
        create: (context) => QuizBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const QuizPage(),
        ),
      ),
    );
  }
}
