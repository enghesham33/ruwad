import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class MultiplayerChallengeWidget extends StatefulWidget {
  const MultiplayerChallengeWidget({super.key});
    static String routeName = "MultiplayerChallengeWidget";

  @override
  createState() => MultiplayerChallengeWidgetState();
}

class MultiplayerChallengeWidgetState extends State<MultiplayerChallengeWidget> {
  /// Map to keep track of score
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    'أكملي قوله تعالى في أول السورة {إن الذين كفروا لن تغني عنهم أموالهم ولا أولادهم من الله شيئا ...}': '{وأولئك هم وقود النار}',
    'قوله تعالى (وقالوا لن تمسنا النار إلا أياما معدودة ...) هي آية': 'البقرة',
    'قوله تعالى (أطيعوا الله والرسول ) بلفظ الرسول ورد في': 'آل عمران',
    // 'Q4': 'ans4',
    // 'Q5': 'ans5',
    // 'Q6': 'ans6'
  };

  // Random seed to shuffle order of items.
  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text(AppLocalizations.of(context)!.exams),
      ),
      
      // AppBar(
      //     title: Text('Score ${score.length} / 6'),
      //     backgroundColor: Colors.pink),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.refresh),
      //   onPressed: () {
      //     setState(() {
      //       score.clear();
      //       seed++;
      //     });
      //   },
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          
          children: [
            Container
            (
              width: 500,
              height: 100,
             decoration:  const BoxDecoration
             (
               color: Palette.lightAccentColor,
               borderRadius: BorderRadius.only
               (
               topLeft: Radius.circular(0),
               topRight: Radius.circular(0),
               bottomLeft: Radius.circular(50),
               bottomRight: Radius.circular(50),
               )
             ),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Center(child: Text('النقاط ${score.length}', style: Theme.of(context).textTheme.headlineLarge,)),
                 const Icon(Icons.paid_rounded, color: Palette.accentColor,)
               ],
             ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: choices.keys.map((question) {
                      return Draggable<String>(
                        data: question,
                        child: Question(question: score[question] == true ? '' : question,),
                        feedback: Question(question: question,),
                        childWhenDragging: Container(),
                      );
                    }).toList()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                        ..shuffle(Random(seed)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(ans) {
    return DragTarget<String>(
      builder: (  BuildContext context,
       List<dynamic> accepted,
       List<dynamic> rejected) {
        if (score[ans] == true) {
          return 
          SizedBox(
              width: 200,
            height: 250,
            child: Card(
                       clipBehavior: Clip.antiAlias,
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                       ),
                       color: Colors.white,
                       elevation: 4.0,
                       margin: const EdgeInsets.all(20.0),
                       child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Lottie.asset(
                       'assets/Animated-star.json',
                       height: 70,width: 70
                       ),
                      ),
                    ),
                  ),
          );
          
         
        } else {
          return SizedBox(
            width: 200,
            height: 250,
            child: Card(
                   clipBehavior: Clip.antiAlias,
                   shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
                   ),
                   color: Palette.accentColor.withOpacity(0.5),
                   elevation: 4.0,
                   margin: const EdgeInsets.all(20.0),
                   child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Center(child: Text(choices[ans]))
                  ),
                ),
              ),
          );
        }
      },
      onWillAccept: (data) => data == ans,
      onAccept: (data) {
        setState(() {
          score[ans] = true;
          if(score.length==choices.length)
          {
              showMyPopup(context);
          }
        });
      },
      onLeave: (data) {},
    );
  }


   void showMyPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the widget for the popup content
        return AlertDialog(
          title: Text('أحسنت'),
          content:  Lottie.asset(
                       'assets/Animated-Dimond.json',
                       height: 70,width: 70
                       ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the popup
                Navigator.of(context).pop();
              },
              child: const Text('استكشف تحديات أخرى'),
            ),
          ],
        );
      },
    );
  }

}

class Question extends StatelessWidget {
  const Question({required this.question}) ;

  final String question;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: question.isEmpty? SizedBox():SizedBox(
         width: 200,
        height: 250,
        child: Card(
                     clipBehavior: Clip.antiAlias,
                     shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),
                     ),
                     color: Palette.lightPrimaryColor.withOpacity(0.5),
                     elevation: 4.0,
                     margin: const EdgeInsets.all(20.0),
                     child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child:  Center(
                      child: Text(
                        question,
                       
                      ),
                    ),
                    ),
                  ),
                ),
      ),
    );
  }


}
