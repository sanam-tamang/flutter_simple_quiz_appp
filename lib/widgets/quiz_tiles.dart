// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:quizapp/models/quiz_model.dart';
import 'package:quizapp/pages/quiz_result_page.dart';

import 'custom_dialog.dart';

class QuizTile extends StatefulWidget {
  final List<QuizModel> quizList;
  const QuizTile({
    Key? key,
    required this.quizList,
  }) : super(key: key);

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  late String quizText;
  late List<String> correct_answer;
  late List<String> incorrect_answers;
  late List<String> all_answers;
  late Timer _timer;
  int _time = 30;
  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();

            if (questionNumber == widget.quizList.length - 1) {
              return;
            } else {
            isSelected = true;

              _nextQuestion();
            }
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  void _loadQuestions() {
    quizText = widget.quizList[currentIndex].question;

    correct_answer = [widget.quizList[currentIndex].correct_answer];

    incorrect_answers = [...widget.quizList[currentIndex].incorrect_answers];

    all_answers = [
      ...correct_answer,
      ...widget.quizList[currentIndex].incorrect_answers
    ]..shuffle();
  }

  void _nextQuestion() {
    if (isSelected) {
      setState(() {
        isSelected = false;
        currentIndex++;
        questionNumber++;
        _loadQuestions();
        _time = 30;
        startTimer();
      });
    } else {
      customDialog(context);
    }
  }

  void _checkResult() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return QuizResultPage(
          point: point,
        );
      },
    ));
  }

  int currentIndex = 0;
  int questionNumber = 0;

  bool isSelected = false;
  bool isCorrect = false;
  int point = 0;
  String selectedAnswer = "";

  @override
  void initState() {
    _loadQuestions();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(_time.toString()),
                  Text(" ${questionNumber + 1} /  ${widget.quizList.length}"),
                  ListTile(
                    title: Text(quizText),
                  ),
                  ...all_answers.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          isSelected
                              ? null
                              : setState(() {
                                  selectedAnswer = e;
                                  print(all_answers.toString());
                                  print(e);
                                  isSelected = true;
                                  _timer.cancel();
                                  if (correct_answer[0] == e) {
                                    print("write answer");
                                    point++;
                                    print(point.toString());
                                  } else {
                                    print("wrong answer");

                                    print(point.toString());
                                  }
                                });
                        },
                        tileColor: isSelected
                            ? correct_answer[0] == e
                                ? Colors.green.shade500
                                : selectedAnswer == e
                                    ? Color.fromARGB(255, 110, 8, 1)
                                    : Color.fromARGB(255, 255, 255, 255)
                            : null,
                        title: Text(e),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          elevation: 10,
          child: Container(
            height: 80,
            child: questionNumber == widget.quizList.length - 1
                ? ElevatedButton(
                    onPressed: isSelected
                        ? () {
                            _checkResult();
                          }
                        : null,
                    child: const Text("Check Result"))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: _nextQuestion,
                            child: const Text("Next")),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
