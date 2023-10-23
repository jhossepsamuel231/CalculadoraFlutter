import 'dart:math'; // Importa la biblioteca math para usar las funciones trigonométricas

class Memory {
  static const operations = const [
    '%',
    '÷',
    '+',
    '-',
    'x',
    '=',
    'sin',
    'cos',
    'sec'
  ];

  String _operation = '';
  bool _usedOperation = false;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _currentOperation = '';

  String getCurrentOperation() {
    return _currentOperation;
  }
// Nueva variable para mantener la operación actual

  String result = '0';

  Memory() {
    _clear();
  }

  void _clear() {
    result = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = '';
    _currentOperation = ''; // Limpia la operación actual
    _usedOperation = false;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
    } else if (command == 'DEL') {
      deleteEndDigit();
    } else if (operations.contains(command)) {
      if (command == 'sin' || command == 'cos' || command == 'sec') {
        _calculateTrigFunction(
            command); // Llama a la función trigonométrica correspondiente
      } else {
        _setOperation(command);
      }
    } else {
      _addDigit(command);
    }
  }

  void deleteEndDigit() {
    result = result.length > 1 ? result.substring(0, result.length - 1) : '0';
  }

  void _addDigit(String digit) {
    if (_usedOperation) result = '0';

    if (result.contains('.') && digit == '.') digit = '';
    if (result == '0' && digit != '.') result = '';

    result += digit;

    _buffer[_bufferIndex] = double.tryParse(result) ?? 0.0;
    _usedOperation = false;
  }

  void _setOperation(String operation) {
  if (_usedOperation && operation == _operation) return;

  if (_bufferIndex == 0) {
    _bufferIndex = 1;
  } else {
    _buffer[0] = _calculate();
  }

  if (operation != '=') {
    if (operation != 'x^') {
      _currentOperation = result + ' ' + operation; // Guarda la operación actual
    } else {
      _currentOperation = result + '^'; // Cambia el formato para la exponenciación
    }
    _operation = operation;
  }

  result = (_buffer[0] ?? 0.0).toString();
  result = result.endsWith('.0') ? result.split('.')[0] : result;

  _usedOperation = true;
}

  void _calculateTrigFunction(String operation) {
    if (_usedOperation && operation == _operation) return;

    if (_bufferIndex == 0) {
      _buffer[0] = _trigFunction(operation, _buffer[0]);
    } else {
      _buffer[1] = _trigFunction(operation, _buffer[1]);
    }

    _currentOperation =
        operation + '(' + result + ')'; // Guarda la operación trigonométrica
    result = (_buffer[_bufferIndex] ?? 0.0).toString();
    _usedOperation = true;
  }

  double _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '÷':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      default:
        return 0.0;
    }
  }

  double _trigFunction(String operation, double value) {
    switch (operation) {
      case 'sin':
        return sin(value);
      case 'cos':
        return cos(value);
      case 'sec':
        return 1 / cos(value);
      default:
        return 0.0;
    }
  }

  void squareRoot() {
    if (_usedOperation) return;
    result = (sqrt(double.tryParse(result) ?? 0.0)).toString();
    _buffer[_bufferIndex] = double.tryParse(result) ?? 0.0;
  }

  void logarithm() {
    if (_usedOperation) return;
    result = (log(double.tryParse(result) ?? 1)).toString();
    _buffer[_bufferIndex] = double.tryParse(result) ?? 0.0;
  }

  void exponentiation() {
    if (_usedOperation) return;
    _setOperation('x^');
  }
}
