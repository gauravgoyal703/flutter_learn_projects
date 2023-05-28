import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/components/questions_indentifier.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  isCorrectAnswer(data) {
    return data['user_answer'] == data['correct_answer'];
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              counter++;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionsIdentifier(counter, isCorrectAnswer(data)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['question'] as String,
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(data['user_answer'] as String,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 202, 171, 252))),
                          Text(data['correct_answer'] as String,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 181, 254, 246))),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
