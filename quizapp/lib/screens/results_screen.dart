import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/components/questions_summary.dart';

import '../data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(this.summaryData, this.restartQuiz, {super.key});

  final void Function() restartQuiz;
  final List<Map<String, String>> summaryData;

  @override
  Widget build(BuildContext context) {
    final int numOfTotalQuestions = questions.length;
    final int numOfCorrectAnswers = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numOfCorrectAnswers out of $numOfTotalQuestions questions correctly!",
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: restartQuiz,
              label: const Text("Restart Quiz!"),
              icon: const Icon(Icons.refresh),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
