// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/optionBox.dart';
import 'resultScreen.dart';

class FindWordScreen extends StatefulWidget {
  final int selectedNumber;
  final int selectedTries;

  const FindWordScreen({
    super.key,
    required this.selectedNumber,
    required this.selectedTries,
  });

  @override
  _FindWordScreenState createState() => _FindWordScreenState();
}

class _FindWordScreenState extends State<FindWordScreen> {
  int _currentWordIndex = 0;
  int _correctGuesses = 0;
  int _wrongGuesses = 0;
  int _currentOptionIndex = -1; // Track the index of currently selected option
  final List<String> _words = [
    'FLUTTER',
    'DEVELOPER',
    'HANGMAN',
    'ALI',
    'ZAIN',
    'SAAD',
    'ADEEB',
    'RAO',
    'GAME',
    'PROJECT',
  ];
  String _currentWord = '';
  String _missingLetter = '';
  bool _showResult = false;
  bool _optionsDisabled = false;
  late List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _generateNewWord();
  }

  void _generateNewWord() {
    setState(() {
      _showResult = false;
      _currentOptionIndex = -1; // Reset the current option index
      _optionsDisabled = false; // Enable options for new word
    });

    _currentWord = _words[_currentWordIndex];
    int missingIndex = Random().nextInt(_currentWord.length);
    _missingLetter = _currentWord[missingIndex];

    _options = [_missingLetter]; // Include the missing letter in options
    while (_options.length < 4) {
      String randomLetter = String.fromCharCode(Random().nextInt(26) + 65);
      if (randomLetter != _missingLetter) {
        _options.add(randomLetter);
      }
    }

    _options.shuffle();
  }

  void _checkGuess(String selectedLetter, int optionIndex) {
    setState(() {
      _showResult = true;
      _optionsDisabled = true; // Disable options after selecting one
      _currentOptionIndex = optionIndex; // Track the selected option index
    });
    if (selectedLetter == _missingLetter) {
      setState(() {
        _correctGuesses++;
      });
    } else {
      setState(() {
        _wrongGuesses++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: buttonColor,
        title: const Text(
          'Complete The Word',
        ),
        backgroundColor: backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Words Count (${_currentWordIndex + 1}/${widget.selectedNumber})',
              style: const TextStyle(color: buttonColor),
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.find_replace_rounded,
              color: buttonColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              _currentWord.replaceFirst(_missingLetter, '_'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            const SizedBox(height: 20),
            _showResult
                ? Text(
                    _options[_currentOptionIndex] == _missingLetter
                        ? 'You selected the correct alphabet!'
                        : 'You selected the wrong alphabet. The correct one was $_missingLetter.',
                    style: TextStyle(
                      color: _options[_currentOptionIndex] == _missingLetter
                          ? whiteColor
                          : redColor,
                      fontSize: 18,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return OptionBox(
                  letter: option,
                  showResult: _showResult,
                  enabled:
                      !_optionsDisabled, // Enable only if options are not disabled
                  onPressed: !_optionsDisabled
                      ? () {
                          _checkGuess(option, index);
                        }
                      :null
                  ,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!_optionsDisabled) {
                  // Show a warning if no option is selected
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: backgroundColor,
                      title: const Text(
                        'Select an Option',
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
                      content: const Text(
                        'Please select an option before proceeding next !',
                        style: TextStyle(
                          color: buttonColor,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  setState(() {
                    if (_currentWordIndex < widget.selectedNumber - 1) {
                      _currentWordIndex++;
                      _generateNewWord();
                    } else {
                      // Navigate to Result Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            correctGuesses: _correctGuesses,
                            wrongGuesses: _wrongGuesses,
                            totalWords: widget.selectedNumber,
                          ),
                        ),
                      );
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: const Text(
                'Next',
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
