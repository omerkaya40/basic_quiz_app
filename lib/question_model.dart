class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question('Who is the founder of Turkish Republic?', [
    Answer('Atatürk', true),
    Answer('Fatih Sultan Mehmet', false),
    Answer('İnönü', false),
    Answer('Özal', false),
  ]));
  list.add(Question('What element does O represent on the periodic table?', [
    Answer('Oxygen', true),
    Answer('Hydrogen', false),
    Answer('Boron', false),
    Answer('Carbon', false),
  ]));
  list.add(Question('What is the name of the river that runs through Egypt?', [
    Answer('Amazon', false),
    Answer('Nile', true),
    Answer('Colorado', false),
    Answer('Rio Grande', false),
  ]));

  return list;
}
