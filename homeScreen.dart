// ignore_for_file: library_private_types_in_public_api, file_names

import 'dart:math';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/findWordScreen.dart';
import '../widgets/numberBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNumber = 1;
  int _selectedTries = 1;
  bool _usePredefinedList = true; // Set predefined list as active
  int? _selectedPredefinedNumber;
  late List<int> _randomNumbers; // Declare as late to initialize in initState
  late List<bool> _isSelected; // Declare as late to initialize in initState

  @override
  void initState() {
    super.initState();
    _generateRandomNumbers();
  }

  void _generateRandomNumbers() {
    _randomNumbers = [];
    _isSelected =
        List.generate(3, (index) => false); // Initialize isSelected list
    while (_randomNumbers.length < 3) {
      int randomNumber = Random().nextInt(10) + 1;
      if (!_randomNumbers.contains(randomNumber)) {
        _randomNumbers.add(randomNumber);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: buttonColor,
        title: const Text('Home Screen'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.home,
              color: buttonColor,
            ),
          ),
        ],
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Number of Words Length',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: _usePredefinedList,
                        onChanged: (bool? value) {
                          setState(() {
                            _usePredefinedList = value!;
                          });
                        },
                        activeColor: buttonColor,
                      ),
                      const Text(
                        'Predefined List',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: _usePredefinedList,
                        onChanged: (bool? value) {
                          setState(() {
                            _usePredefinedList = value!;
                          });
                        },
                        activeColor: buttonColor,
                      ),
                      const Text(
                        'Select Number of Words',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_usePredefinedList)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _randomNumbers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final number = entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPredefinedNumber = number;
                          _isSelected = List.generate(3, (index) => false);
                          _isSelected[index] = true;
                        });
                      },
                      child: NumberBox(
                        number: number,
                        selected: _isSelected[index],
                      ),
                    );
                  }).toList(),
                ),
              if (!_usePredefinedList) const SizedBox(height: 20),
              if (!_usePredefinedList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Select number of words: $_selectedNumber',
                      style: const TextStyle(color: whiteColor),
                    ),
                    Slider(
                      value: _selectedNumber.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 9,
                      onChanged: (value) {
                        setState(() {
                          _selectedNumber = value.round();
                        });
                      },
                      activeColor: buttonColor,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Text(
                'Select number of tries: $_selectedTries',
                style: const TextStyle(color: whiteColor),
              ),
              Slider(
                value: _selectedTries.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    _selectedTries = value.round();
                  });
                },
                activeColor: buttonColor,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_usePredefinedList && _selectedPredefinedNumber == null) {
                    // Show a message or dialog to prompt the user to select a box first
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: backgroundColor,
                        title: const Text(
                          'Select a Box',
                          style: TextStyle(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Please select a number before proceeding next !',
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Proceed to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FindWordScreen(
                          selectedNumber: _usePredefinedList
                              ? _selectedPredefinedNumber ?? 0
                              : _selectedNumber,
                          selectedTries: _selectedTries,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: const Text(
                  'Generate Game',
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
