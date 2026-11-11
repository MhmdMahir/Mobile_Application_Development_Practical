import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bmi = 0.0;
  double _height = 0.0;
  double _weight = 0.0;

  String _bmiOutput = "";
  String _bmiImage = 'assets/images/empty.png';

  //controller
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();

  void _calculateBMI(){
    _weight = double.tryParse(_weightCtrl.text) ?? 0.0;
    _height = double.tryParse(_heightCtrl.text) ?? 0.0;

    setState(() {
      _bmi = _weight / pow(_height, 2);

      if(_bmi < 18.5){
        _bmiImage = 'assets/images/under.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)}[Underweight]';

      }else if (_bmi >= 25){
        _bmiImage = 'assets/images/over.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)}[Overweight]';
      }else {
        _bmiImage = 'assets/images/normal.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)}[Normal Weight]';
      }
    });
  }

  void _resetScreen(){
    _weightCtrl.clear();
    _heightCtrl.clear();

    setState(() {
      _bmi=0;
      _bmiOutput='';
      _bmiImage='assets/images/empty.png';
    });

  }

  @override
  void dispose(){
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Image.asset(
                      _bmiImage
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    alignment: .center,
                    child: _bmi == 0.0
                      ? Text(
                      textAlign: .center,
                      'Enter body weigth and height to know your Body Mass Index (BMI)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      ),
                    ):Text(""),
                  ),
                 ],
              ),const Text(
                'Your Body Mass Index (BMI) is: '
              ), Text(
                _bmiOutput,
                style: Theme.of(context).textTheme.displaySmall,
        ),
        TextField(
            controller: _weightCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter weight (kg)'
            ),
              ),
              TextField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter height (m)'
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  ElevatedButton(onPressed: _resetScreen, child: Text('Reset')),
                  ElevatedButton(onPressed: _calculateBMI, child: Text('Calculate')),
                ],
              ),Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),

    );
  }
}
