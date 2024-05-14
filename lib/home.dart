import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/questions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> scores = [];

  void getScores()async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final scoresSP = _prefs.getStringList("scores");
    if(scoresSP != null){
      setState((){
        scores = scoresSP.map((e) => int.parse(e)).toList();
      });
      scores.sort();
      print(scores);
      scores = scores.reversed.toList();
      print(scores);
    }
  }

  String grade(int point,int totalPoint){

    final result = (point.toDouble()/totalPoint.toDouble()/10.0);
    print(result);
    if(result>0.8){
      print("A");
      return "A";
    }
    else if(result>0.7){
      print("B");
      return "B";
    }
    else if(result>0.6){
      print("C");
      return "C";
    }
    else{
      print("F");
      return "F";
    }
  }

  ColorSwatch<int> medal(int point,int totalPoint){
    final result = (point.toDouble()/totalPoint.toDouble()/10.0);
    print(result);
    if(result>0.8){
      return Colors.yellowAccent;
    }
    else if(result>0.7){
      return Colors.grey;
    }
    else if(result>0.6){
      return Colors.brown;
    }
    else{
      return Colors.blueGrey;
    }
  }

  void saveScore()async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList("scores", scores.map((e) => e.toString()).toList());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)
          ),
          shadowColor: Colors.black87,
          maximumSize: Size(300,50),
          minimumSize: Size(200, 50),
          side: BorderSide(
            color: Colors.black87,
            width: 2
          ),
        ),
        onPressed: () async{
          final result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return Questions();
          }));
          if(result!=null){
            setState(() {
              scores.add(result[0]);
              scores.sort();
              scores = scores.reversed.toList();
            });
            saveScore();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Play", style: GoogleFonts.archivoBlack(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              color: Colors.black87
            ),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("My Scores", style: GoogleFonts.archivoBlack(
              color: CupertinoColors.white,
              fontStyle: FontStyle.italic,
              fontSize: 40,
            ),),
            SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: scores.length>10?10: scores.length,
                itemBuilder: (BuildContext context, int index,) {
                  return Container(
                    margin: index==0?EdgeInsets.only(bottom: 20):EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color:CupertinoColors.white,
                        width: 2.0
                      )
                    ),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      surfaceTintColor: CupertinoColors.white,
                      shadowColor: medal(scores[index], 2),
                      color: medal(scores[index], 2),
                      child: ListTile(
                        trailing: index!=0?Container(
                          padding: EdgeInsets.only(top: 7,left: 5, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            shape: BoxShape.circle
                          ),
                          child: Text("${grade(scores[index], 2)}", style:
                            GoogleFonts.archivoBlack(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color:
                              medal(scores[index], 2)[500])),
                        ):Text("Highest", style: GoogleFonts.archivoBlack(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.yellowAccent,
                      ),),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${scores[index]}", style: GoogleFonts.pacifico(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),),
                            Text(" pts", style: GoogleFonts.archivoBlack(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontStyle: FontStyle.italic
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
            ),
          ],
        ),
      ),
    );
  }
}