import 'dart:convert';

import 'package:quizapp/models/quiz_model.dart';
import 'package:quizapp/services/http_service.dart';

import '../utils.dart';

class QuizService {
  static Future<List<QuizModel>> getQuiz() async {
    try {
      final data = await HttpService.fetchData(quizUrl);
      final decodedData = jsonDecode(data);
      final results = decodedData['results'];
      final List<QuizModel> quizList =
          List.from(results).map((e) => QuizModel.fromMap(e)).toList();
      return quizList;
    } catch (e) {
      throw Exception("Exception occur");
    }
  }
}
