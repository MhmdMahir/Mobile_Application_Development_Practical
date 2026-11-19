import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Loan',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Car Loan'),
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
  //declare local variable
  double _loanAmount = 0.0;
  double _netIncome = 0.0;
  double _interestRate = 0.0;
  int _loanPeriod = 1;
  bool _hasGuarantor = false;
  int _carType = 1; //1 = New, 2 = Used
  double _repaymentAmount = 0.0;
  String _repaymentOutput = '';
  final _years = [1,2,3,4,5,6,7,8,9];

  //controller
  final TextEditingController loanAmountCtrl = TextEditingController();
  final TextEditingController netIncomeCtrl = TextEditingController();
  final TextEditingController interestRateCtrl = TextEditingController();

  //set focus
  final _myFocusNode = FocusNode();

  //format output with currency symbol
  final mycurrency = intl.NumberFormat('#,##0.00', 'ms_My');

  //form controller - manage overall form state

  final _formKey = GlobalKey<FormState>();

  void myAlertDialog(){
    AlertDialog eligibilityAlertDialog = AlertDialog(
      title: const Text('Eligibility'),
      content: const Text('You are not eligible for this loan'
      'Get a guarantor to proceed'),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('Close') //
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return eligibilityAlertDialog;
    });
  }

  void _calculateRepayment(){
    _loanAmount = double.parse(loanAmountCtrl.text);
    _netIncome = double.parse(netIncomeCtrl.text);
    _interestRate = double.parse(interestRateCtrl.text);

    var interest = _loanAmount * _loanPeriod * (_interestRate / 100);

    _repaymentAmount = (_loanAmount + interest) / (_loanPeriod * 12);

    bool eligible = _netIncome * 0.3 >= _repaymentAmount;

    if (eligible || _hasGuarantor) {
      setState(() {
        _repaymentOutput = 'Repayment Amount: '
            '${mycurrency.currencySymbol}'
            '${mycurrency.format(_repaymentAmount)}'
            '\n'
            'Eligibility: ${eligible ? 'Eligible' : 'Not Eligible'}';
      });
    }else {
      myAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey, //without this form wont be able to handle state
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Loan Amount'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: loanAmountCtrl,
                focusNode: _myFocusNode,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter loan amount';
                  }
                  final parsed = double.tryParse(value);
                  if(parsed == null || parsed <= 0){
                    return 'Please enter a loan amount greater than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Net Income'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: netIncomeCtrl,
                focusNode: _myFocusNode,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter Net income';
                  }
                  final parsed = double.tryParse(value);
                  if(parsed == null || parsed <= 0){
                    return 'Please enter a loan amount greater than 0';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                  initialValue: _loanPeriod,
                  items: _years.map((int item){ //map should converted to list
                    return DropdownMenuItem(
                        value: item,
                        child: Text('$item year(s)'));
                  }).toList(),
                  onChanged: (int? item){ //change it to required (shouldn't  be null)
                    setState(() {
                      _loanPeriod = item!;
                    });
                  },
              validator: (value){
                    if(value ==0){
                      return 'Please select an option';
                    }
                    return null;
              },
                decoration: const InputDecoration(
                  labelText: 'Select loan period(year)'
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Interest Rate (%)'
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                controller: interestRateCtrl,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter Interest rate';
                  }
                  final parsed = double.tryParse(value);
                  if(parsed == null || parsed <= 0){
                    return 'Please enter a valid interest rate greater than 0';
                  }
                  return null;
                },
              ),
              CheckboxListTile(value: _hasGuarantor, onChanged: (value){
                setState(() {
                  _hasGuarantor=value!;
                });

              }),
              const Align(
                alignment: .centerLeft,
                child: Text('Car Type', textDirection: .ltr,),
              ),
              RadioGroup(
                  groupValue: _carType,
                  onChanged: (value){
                    setState(() {
                      _carType =value!;
                    });
                  }, child: Column(
                children: [
                  RadioListTile(value: 1, title: Text('New')),
                  RadioListTile(value: 2, title: Text('Old'))
                ],
              )),
              Text(_repaymentOutput),
              ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _calculateRepayment();
                    }
                  }, child: Text('Calculate'))
            ],
          ),
        ),
      ),
    );
  }
}


//what is the controller for
//why homepage is stateful
//what is the child and children
//what is a widget
//Need to know when to use the setState


/*
* Note:
* no helper = lambda expression
* helper function no need lambda expression
*
* */
