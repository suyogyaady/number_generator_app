import 'dart:math';

import 'package:flutter/material.dart';

class NumberGeneratorScreen extends StatefulWidget {
  const NumberGeneratorScreen({super.key});

  @override
  _NumberGeneratorScreenState createState() => _NumberGeneratorScreenState();
}

class _NumberGeneratorScreenState extends State<NumberGeneratorScreen> {
  int number1 = 0;
  int number2 = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int attempts = 0;
  bool gameActive = true;

  void generateRandomNumbers() {
    setState(() {
      number1 = Random().nextInt(100);
      number2 = Random().nextInt(100);
    });
  }

  void handleButtonClick(int selectedNumber) {
    if (!gameActive) return;

    setState(() {
      attempts++;
      if ((selectedNumber == number1 && number1 > number2) ||
          (selectedNumber == number2 && number2 > number1)) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
      if (attempts >= 10) {
        gameActive = false;
      } else {
        generateRandomNumbers();
      }
    });
  }

  void restartGame() {
    setState(() {
      number1 = 0;
      number2 = 0;
      correctAnswers = 0;
      incorrectAnswers = 0;
      attempts = 0;
      gameActive = true;
      generateRandomNumbers(); // Generate new random numbers
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumbers(); // Generate initial random numbers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Generator Game"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                height: 250,
                child: ElevatedButton(
                  onPressed:
                      gameActive ? () => handleButtonClick(number1) : null,
                  child: Text(
                    '$number1',
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 250,
                child: ElevatedButton(
                  onPressed:
                      gameActive ? () => handleButtonClick(number2) : null,
                  child: Text(
                    '$number2',
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                const Text(
                  'Game Stats',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Correct Answers:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$correctAnswers',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Incorrect Answers:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$incorrectAnswers',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Attempts:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$attempts',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: restartGame,
                child: const Text(
                  'Restart Game',
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
