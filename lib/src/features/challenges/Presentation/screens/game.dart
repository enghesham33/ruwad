import 'dart:async';

import 'package:flutter/material.dart';

class ColorGame extends StatefulWidget {
    //static String routeName = "MultiplayerChallengeWidget";

  @override
  _ColorGame createState() => _ColorGame();
}

class _ColorGame extends State<ColorGame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int score = 0;
  int questionNumber = 1;
  bool isCorrect = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    // Start the timer
    startTimer();
  }

  void startTimer() {
    const duration = Duration(seconds: 15);
    timer = Timer(duration, () {
      // Time's up, handle as incorrect
      setState(() {
        isCorrect = false;
        // Move to the next question
        nextQuestion();
      });
    });
  }

  void nextQuestion() {
    // Reset timer for the next question
    timer.cancel();
    startTimer();

    setState(() {
      // Simulate getting the next question
      questionNumber++;

      // Simulate checking if the answer is correct (you would replace this logic)
      isCorrect = true;

      // Update score
      if (isCorrect) {
        score += 10;
      } else {
        // Penalize for incorrect answers (you can customize the penalty)
        score -= 5;
      }

      // Restart the animation for the next question
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplayer Challenge'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Question $questionNumber: What is Flutter?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option selection
                        setState(() {
                          // Stop the timer
                          timer.cancel();
                          // Handle the answer (you would replace this logic)
                          isCorrect = true;
                          // Move to the next question
                          nextQuestion();
                        });
                      },
                      child: Text('Option A'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option selection
                        setState(() {
                          timer.cancel();
                          isCorrect = false;
                          nextQuestion();
                        });
                      },
                      child: Text('Option B'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option selection
                        setState(() {
                          timer.cancel();
                          isCorrect = false;
                          nextQuestion();
                        });
                      },
                      child: Text('Option C'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option selection
                        setState(() {
                          timer.cancel();
                          isCorrect = false;
                          nextQuestion();
                        });
                      },
                      child: Text('Option D'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      isCorrect ? 'Correct!' : 'Incorrect!',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: ColorGame(),
  ));
}
