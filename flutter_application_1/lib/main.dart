// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:math_expressions/math_expressions.dart';

/// The code sets up a Dart application with a MaterialApp widget that serves as the home screen for a
/// calculator app.
void main() {
  runApp(MyApp());
}

/// The `MyApp` class is a stateless widget that represents the main application and sets up the
/// `MaterialApp` with a `CalculatorApp` as the home screen.
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

/// The `CalculatorApp` class is a stateful widget in Dart.
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

/// The `_CalculatorAppState` class is a stateful widget that represents the UI and functionality of a
/// calculator app in Dart.
class _CalculatorAppState extends State<CalculatorApp> {
  double fno = 0.0;
  double sno = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;

  /// The function handles button clicks in a calculator app, performing different actions based on the
  /// value of the clicked button.
  /// 
  /// Args:
  ///   value: The value parameter represents the value of the button that was clicked. It could be any
  /// string value that corresponds to the button's functionality, such as a number, an operator, or a
  /// special command like "AC" or "<-".
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

  /// This function builds a calculator app interface using the Flutter framework in Dart.
  /// 
  /// Args:
  ///   context (BuildContext): The `context` parameter is a required parameter in the `build` method of
  /// a `StatefulWidget`. It represents the current build context of the widget tree. It is typically
  /// used to access the theme, localization, and other information related to the widget's position in
  /// the widget tree.
  /// 
  /// Returns:
  ///   The code is returning a Scaffold widget with a black background. The body of the Scaffold is a
  /// Column widget containing multiple Rows and a Container. The Container is expanded to take up all
  /// available space and has a dark gray color. Inside the Container, there are two Text widgets for
  /// displaying input and output, and some SizedBox widgets for spacing. Below the Container, there are
  /// several Rows of buttons for performing calculations
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

  /// The `button` function is a helper function that creates a custom button widget used in the
  /// calculator app. It takes three optional parameters: `text`, `tcolor`, and `buttonbgColor`.
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
