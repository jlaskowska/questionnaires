import 'package:flutter/material.dart';
import 'package:questionnaires/models/questionnaire.dart';

class QuestionnaireScreen extends StatelessWidget {
  final Questionnaire questionnaire;

  QuestionnaireScreen({@required this.questionnaire});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionnaire.name),
      ),
    );
  }
}
