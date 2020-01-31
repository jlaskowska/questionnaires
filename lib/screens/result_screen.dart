import 'package:flutter/material.dart';
import 'package:questionnaires/widgets/button.dart';

class ResultScreen extends StatelessWidget {
  final String questionnaireName;
  final String interpretation;

  ResultScreen({@required this.questionnaireName, this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionnaireName),
      ),
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * 0.75,
                height: constraints.maxHeight * 0.5,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                        child: Text(
                          'Your Result:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        interpretation,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Button.primary(
                          buttonLabel: 'Main Menu',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                    //
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
