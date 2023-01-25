import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import './buttons.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = 'text';
  var answer = '';

  final List<String> buttons = [
    'C',
    '(',
    ')',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text( 
                      userInput, 
                      style: TextStyle(fontSize: 18, color: Colors.white)
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text( 
                      answer, 
                      style: TextStyle(fontSize: 28, color: Colors.white)
                    )
                  )
                ]
              )
            )
          ), 
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
              ),
              itemBuilder: (BuildContext context, int index) {
                if(index == 0) {
                  return MyButton(
                    buttonTapped:(){
                      setState((){
                        userInput = '';
                        answer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red[50],
                    textColor: Colors.black
                  );
                } else if(index == 3) {
                  return MyButton(
                    buttonTapped:(){
                     setState((){  userInput = userInput.substring(0, userInput.length - 1); });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue[50],
                    textColor: Colors.black
                  );
                } else if(index == 18) {
                  return MyButton(
                    buttonTapped:(){
                      setState((){ equalPressed(); });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange[50],
                    textColor: Colors.black
                  );
                } else {
                  return MyButton(
                    buttonTapped:(){
                      setState((){  userInput = userInput + buttons[index]; });
                    },
                    buttonText: buttons[index],
                    color: (isOperator(buttons[index]) ? Colors.blue[50] : Colors.white),
                    textColor: Colors.black
                  );
                }
              },
            )
          )
        ],
      ),
    );
  }

  void equalPressed(){
    String finalInput = userInput; 

    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  } 
  bool isOperator(str) {
    if(str == '+' || str == '-' || str == '*' || str == '/' || str == '(' || str == ')') {
      return true; 
    } else {return false; }
  }
}
