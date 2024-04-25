// ignore_for_file: file_names, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'homeScreen.dart';

class ResultScreen extends StatelessWidget {
  final int correctGuesses;
  final int wrongGuesses;
  final int totalWords;

  const ResultScreen({
    Key? key,
    required this.correctGuesses,
    required this.wrongGuesses,
    required this.totalWords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (correctGuesses / totalWords) * 100;
    bool passed = percentage >= 60;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: buttonColor,
        title: const Text('Result'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.query_stats_outlined,
              color: buttonColor,
            ),
          )
        ],
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: passed
            ? _buildPassedResult(percentage, context)
            : _buildFailedResult(
                correctGuesses, wrongGuesses, percentage, context),
      ),
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildPassedResult(double percentage, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Correct Guesses: $correctGuesses',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 10),
        Text(
          'Wrong Guesses: $wrongGuesses',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 10),
        Text(
          'Percentage: ${percentage.toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 20),
        const Text(
          'Congratulations! You Have Passed The Hangman',
          style: TextStyle(fontSize: 20, color: buttonColor),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _navigateToHome(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Text(
            'Generate Game Again',
            style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildFailedResult(int correctGuesses, int wrongGuesses,
      double percentage, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Correct Guesses: $correctGuesses',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 10),
        Text(
          'Wrong Guesses: $wrongGuesses',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 10),
        Text(
          'Percentage: ${percentage.toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(height: 20),
        const Text(
          'Sorry, you did not pass the Hangman !',
          style: TextStyle(fontSize: 20, color: buttonColor),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToHome(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: const Text(
                'Generate Game Again',
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
