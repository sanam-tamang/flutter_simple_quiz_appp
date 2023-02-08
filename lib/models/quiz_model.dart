import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class QuizModel {
  final String question;
  final String correct_answer;
  final List<String> incorrect_answers;
  QuizModel({
    required this.question,
    required this.correct_answer,
    required this.incorrect_answers,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
        question: map['question'] as String,
        correct_answer: map['correct_answer'] as String,
        incorrect_answers: List.from(
          (map['incorrect_answers']),
        ));
  }

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
