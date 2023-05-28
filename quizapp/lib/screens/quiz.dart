import 'package:flutter/material.dart';
import 'package:quizapp/screens/questions_screen.dart';
import 'package:quizapp/screens/results_screen.dart';
import 'package:quizapp/screens/start_screen.dart';
import 'package:quizapp/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String activeScreen = "start-screen";

  final List<Map<String, String>> selectedAnswer = [];

  switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  chooseAnswer(
      final String question, final String answer, final String correctAnswer) {
    selectedAnswer.add({
      "question": question,
      "user_answer": answer,
      "correct_answer": correctAnswer
    });

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  restartQuiz() {
    selectedAnswer.clear();
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    var changeScreen = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : activeScreen == "question-screen"
            ? QuestionsScreen(chooseAnswer)
            : ResultsScreen(selectedAnswer, restartQuiz);
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: changeScreen),
      ),
    );
  }
}
