import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark, // Устанавливаем темный режим
        useMaterial3: true,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  String expression = ""; // Store the expression
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "АС") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      expression = ""; // Clear the expression
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      expression += " $num1 $operand"; // Update the expression
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      expression += " $num2"; // Add the second operand to the expression
      if (operand == "+") {
        _output = (num1 + num2).toStringAsFixed(2);
      } else if (operand == "-") {
        _output = (num1 - num2).toStringAsFixed(2);
      } else if (operand == "*") {
        _output = (num1 * num2).toStringAsFixed(2);
      } else if (operand == "/") {
        _output = (num1 / num2).toStringAsFixed(2);
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "^") { // Возведение в степень
      num1 = double.parse(output);
      _output = math.pow(num1, 2).toStringAsFixed(2);
    } else if (buttonText == "√") { // Квадратный корень
      num1 = double.parse(output);
      _output = math.sqrt(num1).toStringAsFixed(2);
    } else if (buttonText == "%") {
      num1 = double.parse(output);
      _output = (num1 / 100).toStringAsFixed(2);
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildCircularButton(String buttonText) {
    final isNumberOrDecimal = RegExp(r'^[0-9.]$').hasMatch(buttonText);
    final isClearButton = buttonText == "АС";
    final isEqualsButton = buttonText == "=";
    final isRootButton = buttonText == "√";
    final isPercentageButton = buttonText == "%";
    final isPowerButton = buttonText == "^";
    final isOperatorButton = ["+", "-", "*", "/", "√"].contains(buttonText);

    Color buttonColor = isEqualsButton || isRootButton  ? Colors.grey.shade500 : Colors.grey;
    Color textColor = isNumberOrDecimal || isEqualsButton ? Colors.white : Colors.black;
    Color borderColor = isRootButton || isPercentageButton ? Colors.grey.shade200 : Colors.transparent;

    if (isClearButton || isPowerButton || isPercentageButton) {
      buttonColor = Colors.grey.shade300; // Серый фон для кнопок "АС" и "^"
    } else if (isOperatorButton) {
      buttonColor = Colors.orange; // Оранжевый фон для операторов
    }

    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: buttonColor,
        border: Border.all(  width: 0.0,),
      ),
      child: Center(
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 26.0,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0), // Add padding around the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
          children: <Widget>[
            Text(
              expression, // Display the expression
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.0), // Add space between expression and result
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCircularButton("АС"),
                    buildCircularButton("^"),
                    buildCircularButton("%"),
                    buildCircularButton("/"),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCircularButton("7"),
                    buildCircularButton("8"),
                    buildCircularButton("9"),
                    buildCircularButton("*"),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCircularButton("4"),
                    buildCircularButton("5"),
                    buildCircularButton("6"),
                    buildCircularButton("-"),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCircularButton("1"),
                    buildCircularButton("2"),
                    buildCircularButton("3"),
                    buildCircularButton("+"),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCircularButton("."),
                    buildCircularButton("0"),
                    buildCircularButton("="),
                    buildCircularButton("√"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
