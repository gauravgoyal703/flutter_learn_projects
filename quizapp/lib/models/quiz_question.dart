class QuizQuestion {
  const QuizQuestion(this.question, this.answers, this.correctAnswer);

  final String question;
  final List<String> answers;
  final String correctAnswer;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
