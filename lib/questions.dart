import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/score.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List<Map<String, dynamic>> questions = [
    {
      "image":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkX287b5M1qtofKZF3d-jnfnWbLc8VX4YKN7w6YtGINw&s",
      "question":"What is your name",
      "answer":"Ahmad",
      "type":"multiple",
      "choices":[
        "Ahmad",
        "Aiman",
        "Amir"
      ]
    },
    {
      "question":"Is it true or false?",
      "answer":"False",
      "type":"tf",
      "choices":[
        "True",
        "False"
      ]
    }
  ];

  int currentQuestion = 0;
  Timer? timer;
  int remainingSeconds=10;
  String? choice;
  int score = 0;

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        setState(() {
          timer.cancel();
        });
        questionEnd();
      }
      else {
        setState(() {
          remainingSeconds--;
          print(1);
        });
      }
      print(remainingSeconds);
    })
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        iconTheme: IconThemeData(
          color: CupertinoColors.white,
          size: 35
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text("Question ${currentQuestion+1}", style:
          GoogleFonts.archivoBlack(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),),
      ),
      body: 
      Column(
        children: [
          SizedBox(height: 10,),
          Text(" ${remainingSeconds}s", style: GoogleFonts.archivoBlack(
            fontSize: 40,
            fontStyle: FontStyle.italic
          ),),
          SizedBox(height: 20,),
          questions[currentQuestion]["image"]==null?SizedBox():ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(questions[currentQuestion]["image"])),
          SizedBox(height: 20,),
          Text("${questions[currentQuestion]["question"]}", style: GoogleFonts.archivoBlack(
            fontStyle: FontStyle.normal,
            fontSize: 16,
            color: CupertinoColors.white
          ),),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: (questions[currentQuestion]["choices"]as List).length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ListTile(
                    title: Text("${questions[currentQuestion]["choices"][index]}", style: GoogleFonts.archivoBlack(
                      color: CupertinoColors.white,
                      fontSize: 16
                    ),),
                    leading: Radio(
                      splashRadius: 10.0,
                      activeColor: CupertinoColors.white,
                      value:questions[currentQuestion]["choices"][index],
                      groupValue: choice,
                      onChanged: (value) {
                        setState(() {
                          choice = value;
                        });
                      },

                    ),
                  ),
                );
            },),
          ),
          ElevatedButton(
              onPressed:timer!=null? (){
                questionEnd();
              }:null, child: Text("Submit"))
        ],
      ),
    );
  }
  void questionEnd(){
    timer?.cancel();
    if(questions[currentQuestion]["answer"]==choice){
      setState(() {
        score+=remainingSeconds;
      });
    }
    if(currentQuestion<questions.length-1){
      setState(() {
        remainingSeconds = 10;
        currentQuestion+=1;
      });
      startTimer();
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return ScorePage(score: score, total: questions.length,);
      }));
    }
  }
}
