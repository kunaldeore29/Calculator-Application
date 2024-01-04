// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
      title: 'Calculator App',
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double fno = 0.0;
  double sno = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;

  onbuttonclick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 54;

      }
    } else {
      input = input + value;
      hideinput = false;
        outputsize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Color.fromARGB(255, 18, 18, 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(hideinput ? '' : input,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(output,
                      style: TextStyle(
                        fontSize: outputsize,
                        color: Colors.white.withOpacity(0.7),
                      )),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                  text: "AC",
                  buttonbgColor: operatorColor,
                  tcolor: orangeColor),
              button(
                  text: "<-",
                  buttonbgColor: operatorColor,
                  tcolor: orangeColor),
              button(text: "", buttonbgColor: Colors.transparent),
              button(text: "/", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonbgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "0"),
              button(text: "%", buttonbgColor: operatorColor),
              button(text: ".", buttonbgColor: operatorColor),
              button(text: "=", buttonbgColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, buttonbgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            primary: buttonbgColor,
          ),
          onPressed: () => onbuttonclick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
