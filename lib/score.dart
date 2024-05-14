import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.score, required this.total});
  final int score;
  final int total;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You Scored", style: GoogleFonts.archivoBlack(
              fontSize: 20,
              color: CupertinoColors.white,
              fontStyle: FontStyle.italic

            ),),
            SizedBox(height: 10,),
            Text("${widget.score}",style: GoogleFonts.archivoBlack(
                fontSize: 80,
                color: CupertinoColors.white,
                fontStyle: FontStyle.italic

            )),
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CupertinoColors.white
                ),
                onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context,[widget.score, widget.total]);
            }, child: Text("Back Home", style: GoogleFonts.archivoBlack(
              color: Colors.black87,
              fontSize: 20,
              fontStyle: FontStyle.italic
            ),))
          ],
        ),
      ),
    );
  }
}
