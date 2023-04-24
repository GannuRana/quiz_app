import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizBrain=QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override

  List<Icon> scorekeeper=[];
  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer=quizBrain.getCorrectAnswer();
    //The user picked true.


    setState(() {
      if (quizBrain.isFinished() == true) {
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();
        
        scorekeeper=[];
      }
     else {
        if (userPickedAnswer == correctAnswer) {
          scorekeeper.add(Icon(Icons.check, color: Colors.green,));
        }
        else {
          scorekeeper.add(Icon(Icons.close, color: Colors.red,));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  int questionNumber=0;
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
               quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
           child: Text('true'),
          onPressed: () {
              checkAnswer(true);
            },
              style: TextButton.styleFrom(
              primary: Colors.white,
                backgroundColor: Colors.green,

            ),
          ),
        ),
        ),//
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text('false'),
              onPressed: (){
              checkAnswer(false);
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),

          ),
        ),
        // TODO: Add a Row here as your score keeper
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
