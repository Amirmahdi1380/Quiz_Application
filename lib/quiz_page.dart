import 'package:flutter/material.dart';
import 'package:quiz_application/Screen/result_screen.dart';
import 'package:quiz_application/constant/constant.dart';
import 'package:quiz_application/data/Question.dart';

class quiz extends StatefulWidget {
  quiz({Key? key}) : super(key: key);

  @override
  State<quiz> createState() => _quizState();
}

Question? selectedQuestion;
bool isFinalSubmited = false;
int correctAnswer = 0;

class _quizState extends State<quiz> {
  int shownQuestionIndex = 0;
  var list = [
    ListTile(
      title: Text(
        'پاسخ اول',
        textAlign: TextAlign.end,
      ),
    ),
    ListTile(
      title: Text(
        'پاسخ دوم',
        textAlign: TextAlign.end,
      ),
    ),
    ListTile(
      title: Text(
        'پاسخ سوم',
        textAlign: TextAlign.end,
      ),
    ),
    ListTile(
      title: Text(
        'پاسخ چهارم',
        textAlign: TextAlign.end,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    int allQuestion = getQuestionList().length;
    int now = shownQuestionIndex + 1;
    selectedQuestion = getQuestionList()[shownQuestionIndex];
    String questionImageIndex = selectedQuestion!.imageNameNumber!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("سوال $now از $allQuestion"),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          Image(
            height: 300,
            image: AssetImage('images/$questionImageIndex.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            selectedQuestion!.questionTitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ...List.generate(
            4,
            (index) => getOptionItem(index),
          ),
          if (isFinalSubmited)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: Size(200, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ResultScreen(
                      correctAnswer: correctAnswer,
                    ),
                  ),
                );
              },
              child: Text(
                'دیدن نتایج',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
        ],
      )),
    );
  }

  Widget getOptionItem(int index) {
    return ListTile(
      title: Text(
        selectedQuestion!.answerList![index],
        textAlign: TextAlign.end,
      ),
      onTap: () {
        if (selectedQuestion!.correctAnswer == index) {
          correctAnswer++;
        } else
          print('wrong');
        if (shownQuestionIndex == getQuestionList().length - 1) {
          isFinalSubmited = true;
        }
        setState(() {
          if (shownQuestionIndex < getQuestionList().length - 1) {
            shownQuestionIndex++;
          }
        });
      },
    );
  }
}
