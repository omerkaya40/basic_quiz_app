import 'package:basic_quiz_app/question_model.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 200, 235),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Basic Quiz App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                _questionWidget(),
                _answerList(),
                _nextButton(),
              ]),
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Question ${currentQuestionIndex + 1}/${questionList.length.toString()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent]),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0)),
              ]),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
          child: Text(answer.answerText),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              foregroundColor: isSelected ? Colors.orangeAccent : Colors.white,
              backgroundColor: isSelected
                  ? Colors.white
                  : Color.fromARGB(255, 103, 153, 238)),
          onPressed: () {
            setState(() {
              if (selectedAnswer == null) {
                if (answer.isCorrect) {
                  score++;
                }
              }

              selectedAnswer = answer;
            });
          }),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
          child: Text(isLastQuestion ? 'Submit' : 'Next Question'),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 0, 94, 255)),
          onPressed: () {
            if (selectedAnswer == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Please select an answer before going to the next question')));
              return;
            }

            if (isLastQuestion) {
              showDialog(context: context, builder: (_) => _showScoreWindow());
            } else {
              setState(() {
                selectedAnswer = null;
                currentQuestionIndex++;
              });
            }
          }),
    );
  }

  _showScoreWindow() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
      isPassed = true;
    }
    String title = isPassed ? 'Passed' : 'Failed';
    return AlertDialog(
      title: Text(
        title + '  | Score is $score',
        style: TextStyle(color: isPassed ? Colors.green : Colors.red),
      ),
      content: ElevatedButton(
        child: Text('Restart'),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}
