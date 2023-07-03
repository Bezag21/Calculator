import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _expression = '';
  double _memoryValue = 0;
 
  void _onPressed(String buttonValue) {
    setState(() {
      if (buttonValue == 'C') {
        _output = '0';
        _expression = '';
      } else if (buttonValue == '<-') {
        _output = _output.substring(0, _output.length - 1);
        if (_output.isEmpty) {
          _output = '0';
        }
        _expression = _expression.substring(0, _expression.length - 1);
        if (_expression.isEmpty) {
          _expression = '0';
        }
      } else if (buttonValue == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          _output = eval.toString();
          _expression = eval.toString();
        } catch (e) {
          _output = 'Error';
          _expression = '';
        }
      } else if (buttonValue == '√') {
        double? value = double.tryParse(_output);
        if (value != null) {
          _output = math.sqrt(value).toString();
          _expression = 'sqrt($_output)';
        } else {
          _output = 'Error';
          _expression = '';
        }
      } else if (buttonValue == '%') {
        double? value = double.tryParse(_output);
        if (value != null) {
          _output = (value / 100.0).toString();
          _expression = '($_output%)';
        } else {
          _output = 'Error';
          _expression = '';
        }
      } else if (buttonValue == 'MS') {
        _memoryValue = double.tryParse(_output) ?? 0;
      } else if (buttonValue == 'M+') {
        _memoryValue += double.tryParse(_output) ?? 0;
      } else if (buttonValue == 'M-') {
        _memoryValue -= double.tryParse(_output) ?? 0;
      } else if (buttonValue == 'MR') {
        _output = _memoryValue.toString();
        _expression = _memoryValue.toString();
      } else if (buttonValue == 'ln') {
  double? value = double.tryParse(_output);
  if (value != null && value > 0) {
    _output = math.log(value).toString();
    _expression = 'log($_output)';
  } else {
    _output = 'Error';
    _expression = '';
  }
}else if (buttonValue == 'log') {
      double? value = double.tryParse(_output);
      if (value != null && value > 0) {
        _output = ((math.log(value))/2.305).toString();
        _expression = 'log($_output)';
      } else {
        _output = 'Error';
        _expression = '';
      }
    }else if (buttonValue == 'sin') {
  double? value = double.tryParse(_output);
  if (value != null) {
    double radians = value * math.pi / 180.0;
    _output = math.sin(radians).toString();
    _expression = 'sin($_output)';
  } else {
    _output = 'Error';
    _expression = '';
  }
} else if (buttonValue == 'cos') {
      double? value = double.tryParse(_output);
      if (value != null) {
        double radians = value * math.pi / 180.0;
        _output = math.cos(radians).toString();
        _expression = 'cos($_output)';
      } else {
        _output = 'Error';
        _expression = '';
      }
    } else if (buttonValue == 'tan') {
      double? value = double.tryParse(_output);
      if (value != null) {
        double radians = value * math.pi / 180.0;
        if ((radians / (math.pi / 2)) % 2 == 1) {
          _output = 'Error';
          _expression = '';
        } else {
          _output = math.tan(radians).toString();
          _expression = 'tan($_output)';
        }
      } else {
        _output = 'Error';
        _expression = '';
      }
    }else {
        if (_output == '0') {
          _output = buttonValue;
          _expression = buttonValue;
        } else {
          _output += buttonValue;
          _expression += buttonValue;
        }
      }
    });
  }

  final List<String> _buttons = [
    'sin', 'cos', 'tan', 'log', 'C',
    '^', '√', 'ln', '*', '%',
    '7', '8', '9', '/', 'MS',
    '4', '5', '6', '-','M+',
    '1', '2', '3', '+','M-',
    '.', '0', '=', '<-','MR',  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scientific Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: _buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                itemBuilder: (BuildContext context, int index) {
                  String buttonText = _buttons[index];
                  return MaterialButton(
                    onPressed: () => _onPressed(buttonText),
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 24.0),
                     

                    ),
                     color: buttonText == 'C' ? Colors.grey : null,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}