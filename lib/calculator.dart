import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'memory.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _memory = Memory();
  String _currentOperation = ''; // Variable para la operación actual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Calculadora De Jhossep'),
        ),
        body: Column(
          children: <Widget>[
            _buildDisplay(),
            Divider(height: 0.1),
            _buildKeyboard(),
          ],
        ));
  }

  Widget _buildOperationDisplay() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoSizeText(
        _memory.getCurrentOperation(), // Obtén la operación actual desde Memory
        minFontSize: 20.0,
        maxFontSize: 40.0,
        maxLines: 1,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.none,
          fontSize: 40.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildOperationDisplay(), // Muestra la operación actual
            AutoSizeText(
              _memory.result,
              minFontSize: 20.0,
              maxFontSize: 80.0,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.none,
                fontSize: 80.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardButton(String label,
      {int flex = 1,
      Color textColor = Colors.white,
      Color backgroundColor = Colors.black}) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () {
          setState(() {
            if (label == '√') {
              _memory.squareRoot();
            } else if (label == 'log') {
              _memory.logarithm();
            } else if (label == 'x^') {
              _memory.exponentiation();
            } else {
              _memory.applyCommand(label);
            }
          });
        },
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      color: Colors.black,
      height: 400.0,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('AC', textColor: Colors.deepOrange),
                _buildKeyboardButton('DEL', textColor: Colors.deepOrange),
                _buildKeyboardButton('%', textColor: Colors.deepOrange),
                _buildKeyboardButton('÷', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('sin', textColor: Colors.deepOrange),
                _buildKeyboardButton('cos', textColor: Colors.deepOrange),
                _buildKeyboardButton('sec', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('√', textColor: Colors.deepOrange),
                _buildKeyboardButton('log', textColor: Colors.deepOrange),
                _buildKeyboardButton('x^', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('7'),
                _buildKeyboardButton('8'),
                _buildKeyboardButton('9'),
                _buildKeyboardButton('x', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('4'),
                _buildKeyboardButton('5'),
                _buildKeyboardButton('6'),
                _buildKeyboardButton('+', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('1'),
                _buildKeyboardButton('2'),
                _buildKeyboardButton('3'),
                _buildKeyboardButton('-', textColor: Colors.deepOrange),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('0', flex: 2),
                _buildKeyboardButton('.'),
                _buildKeyboardButton('=', textColor: Colors.deepOrange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
