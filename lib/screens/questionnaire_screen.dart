import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:questionnaires/models/question.dart';
import 'package:questionnaires/models/questionnaire.dart';
import 'package:questionnaires/screens/home_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  final Questionnaire questionnaire;

  QuestionnaireScreen({@required this.questionnaire});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  List<Question> get questions => widget.questionnaire.questions;
  int questionIndex;
  Question get currentQuestion => questions[questionIndex];
  int get numberOfQuestions => questions.length;
  List<int> chosenAnswers;
  bool get userHasAnsweredCurrentQuestion => chosenAnswers[questionIndex] != null;

  @override
  void initState() {
    super.initState();

    questionIndex = 0;
    chosenAnswers = List<int>(numberOfQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(widget.questionnaire.name),
      ),
      body: SafeArea(
        child: Center(
          child: Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                DotsIndicator(
                  dotsCount: numberOfQuestions,
                  position: questionIndex.toDouble(),
                  decorator: DotsDecorator(
                    size: Size.square(15),
                    activeSize: Size(18, 18),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  currentQuestion.text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                RadioButtonGroup(
                  activeColor: Theme.of(context).primaryColor,
                  labels: currentQuestion.answers.map((answer) => answer.text).toList(),
                  onChange: (_, answerIndex) => setState(() {
                    chosenAnswers[questionIndex] = answerIndex;
                  }),
                  picked:
                      !userHasAnsweredCurrentQuestion ? "" : currentQuestion.answers[chosenAnswers[questionIndex]].text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Visibility(
                      visible: questionIndex != 0,
                      child: RaisedButton(
                        child: Text('Back'),
                        onPressed: () {
                          if (questionIndex > 0) {
                            setState(() {
                              questionIndex--;
                            });
                          }
                        },
                      ),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text('Next'),
                      onPressed: userHasAnsweredCurrentQuestion
                          ? () {
                              if (questionIndex < numberOfQuestions - 1) {
                                setState(() {
                                  questionIndex++;
                                });
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            }
                          : null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
