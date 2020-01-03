import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:questionnaires/configs/app_colors.dart';
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
  String get instructions => widget.questionnaire.instructions;

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Text(
                  instructions,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: DotsIndicator(
                          dotsCount: numberOfQuestions,
                          position: questionIndex.toDouble(),
                          decorator: DotsDecorator(
                            size: Size.square(15),
                            activeSize: Size(18, 18),
                            activeColor: Theme.of(context).primaryColor,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 8.0),
                        child: Text(
                          currentQuestion.text,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      RadioButtonGroup(
                        activeColor: Theme.of(context).primaryColor,
                        labels: currentQuestion.answers.map((answer) => answer.text).toList(),
                        onChange: (_, answerIndex) => setState(() {
                          chosenAnswers[questionIndex] = answerIndex;
                        }),
                        picked: !userHasAnsweredCurrentQuestion
                            ? ""
                            : currentQuestion.answers[chosenAnswers[questionIndex]].text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Visibility(
                              visible: questionIndex != 0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                ),
                                child: Text(
                                  'Back',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
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
                              child: Text(
                                'Next',
                                style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).accentColor),
                              ),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
