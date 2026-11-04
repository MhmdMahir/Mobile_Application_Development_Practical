import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hui Xin is Gay'),
          backgroundColor: Colors.limeAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Center(
                child: Text('Login'),
              ),
              SizedBox(height: 8.0,),
              TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 8.0,),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 8.0,),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('login')),
              SizedBox(height: 8.0,),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('Register')),
              SizedBox(height: 8.0,)
            ],
          ),
        ),
      ),
    );
  }
}
