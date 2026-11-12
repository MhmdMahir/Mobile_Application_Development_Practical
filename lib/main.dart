
import 'dart:math';
import 'package:flutter/material.dart';

import 'info.dart';

void main() {
  runApp(const MyApp());
}

// ==========================================
// MAIN APPLICATION
// ==========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(
        title: 'BMI Calculator',
      ),
    );
  }
}

// ==========================================
// HOME PAGE
// ==========================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // ----------------------------------------
  // VARIABLES
  // ----------------------------------------

  double _bmi = 0.0;
  double _height = 0.0;
  double _weight = 0.0;

  String _bmiOutput = '';
  String _bmiImage = 'assets/images/empty.png';

  // Text Editing Controllers
  final TextEditingController _weightCtrl =
  TextEditingController();

  final TextEditingController _heightCtrl =
  TextEditingController();


  // ----------------------------------------
  // BMI CALCULATION
  // ----------------------------------------

  void _calculateBMI() {

    _weight = double.tryParse(_weightCtrl.text) ?? 0.0;
    _height = double.tryParse(_heightCtrl.text) ?? 0.0;

    // Validate input
    if (_weight <= 0 || _height <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid weight and height.'),
        ),
      );
      return;
    }

    setState(() {

      // BMI Formula: Weight / Height²
      _bmi = _weight / pow(_height, 2);

      // Determine BMI Category
      if (_bmi < 18.5) {

        _bmiImage = 'assets/images/under.png';
        _bmiOutput =
        '${_bmi.toStringAsFixed(2)} [Underweight]';

      } else if (_bmi >= 25) {

        _bmiImage = 'assets/images/over.png';
        _bmiOutput =
        '${_bmi.toStringAsFixed(2)} [Overweight]';

      } else {

        _bmiImage = 'assets/images/normal.png';
        _bmiOutput =
        '${_bmi.toStringAsFixed(2)} [Normal Weight]';

      }
    });
  }

  void _resetScreen() {

    _weightCtrl.clear();
    _heightCtrl.clear();

    setState(() {
      _bmi = 0.0;
      _bmiOutput = '';
      _bmiImage = 'assets/images/empty.png';
    });
  }


  // ----------------------------------------
  // NAVIGATE TO INFO PAGE
  // ----------------------------------------

  void _openInfoPage() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Info(
          bmi: _bmiOutput,
        ),
      ),
    );
  }


  // ----------------------------------------
  // DISPOSE CONTROLLERS
  // ----------------------------------------

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }


  // ========================================
  // BUILD USER INTERFACE
  // ========================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // --------------------------------
              // BMI IMAGE AND DESCRIPTION
              // --------------------------------

              Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(_bmiImage),
                  ),

                  if (_bmi == 0.0)
                    Container(
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: const Text(
                        'Enter body weight and height '
                            'to know your Body Mass Index (BMI)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 15),

              // --------------------------------
              // BMI RESULT
              // --------------------------------

              const Text(
                'Your Body Mass Index (BMI) is:',
              ),

              Text(
                _bmiOutput,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              // --------------------------------
              // WEIGHT INPUT
              // --------------------------------

              TextField(
                controller: _weightCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Enter weight (kg)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // --------------------------------
              // HEIGHT INPUT
              // --------------------------------

              TextField(
                controller: _heightCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Enter height (m)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------
              // INFO BUTTON
              // --------------------------------

              IconButton(
                onPressed: _openInfoPage,
                icon: const Icon(
                  Icons.info,
                  size: 48,
                  color: Colors.amber,
                ),
              ),

              // --------------------------------
              // RESET AND CALCULATE BUTTONS
              // --------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: _resetScreen,
                    child: const Text('Reset'),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: _calculateBMI,
                    child: const Text('Calculate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
