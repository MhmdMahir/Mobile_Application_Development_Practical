import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Info extends StatelessWidget {
  final String bmi;


  const Info({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('BMI Info')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text('Body mass index (BMI) is a value derived from the mass (weight)'
              'and height of a person.\n\n The BMI is defined as the body mass'
              'divided by the square of the body height, and is expressed in units'
              'of kg/m\u00B2, resulting from mass in kilograms (kg) and height'
              'in meters (m)'),
              Table(
                border: TableBorder.all(color: Colors.orangeAccent),
                children: const[
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TableCell(child: Text(
                          'BMI Value',
                          textAlign: .center,
                          style: TextStyle(fontWeight: .bold),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TableCell(child: Text(
                          'Classification',
                          textAlign: .center,
                          style: TextStyle(fontWeight: .bold),
                        )),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TableCell(child:
                        Center(child: Text('Below 18.5'))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TableCell(child:
                        Center(child: Text('Underweight'))),
                      )
                    ]
                  ),
                  TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCell(child:
                          Center(child: Text('18.5 - 24.9'))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCell(child:
                          Center(child: Text('Normal'))),
                        )
                      ]
                  ),
                  TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCell(child:
                          Center(child: Text('Over 24.9'))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TableCell(child:
                          Center(child: Text('Overweight'))),
                        )
                      ]
                  ),
                ],
              ),
              bmi == ''? Text('Please enter your weight and height'):
                Text('Your Body Mass Index (BMI) is $bmi'),
            Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
                },
            child: Text('Back'))
            ],
          ),
        ),
      ),
    );
  }
}
