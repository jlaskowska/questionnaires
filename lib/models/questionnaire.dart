import 'package:meta/meta.dart';
import 'package:questionnaires/models/interpretation.dart';
import 'package:questionnaires/models/question.dart';

class Questionnaire {
  final String name;
  final String instructions;
  final List<Question> questions;
  final List<Interpretation> interpretations;

  Questionnaire({
    @required this.name,
    @required this.instructions,
    @required this.questions,
    @required this.interpretations,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        name: json['name'],
        instructions: json['instructions'],
        questions: List<Question>.from(json['questions'].map((x) => Question.fromJson(x))),
        interpretations: List<Interpretation>.from(json['interpretations'].map((x) => Interpretation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'instructions': instructions,
        'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
        'interpretations': List<dynamic>.from(interpretations.map((x) => x.toJson())),
      };

  @override
  String toString() => toJson().toString();
}
