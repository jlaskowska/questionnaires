import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:questionnaires/models/question.dart';
import 'package:questionnaires/models/questionnaire.dart';

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

  @override
  void initState() {
    super.initState();

    questionIndex = 0;
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
                Text(currentQuestion.text),
                RadioButtonGroup(
                  labels: currentQuestion.answers.map((answer) => answer.text).toList(),
                  onChange: (_, index) => print(index),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Back'),
                      onPressed: null,
                    ),
                    RaisedButton(
                      child: Text('Next'),
                      onPressed: null,
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
