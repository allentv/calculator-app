import 'constants.dart';


class CalculatorManager {
  double firstNum;
  double secondNum;
  String result;
  String operationToPerform;
  bool _isDoubleOperation = false;

  var operations = {
    CalculatorConstants.ADDITION: (a, b) => (a + b).toString(),
    CalculatorConstants.SUBTRACTION: (a, b) => (a - b).toString(),
    CalculatorConstants.DIVISION: (a, b) => (a / b).toString(),
    CalculatorConstants.MULTIPLICATION: (a, b) => (a * b).toString(),
  };

  String _executeOperation(String operation, double firstNum, double secondNum) {
    return operations[operation](firstNum, secondNum);
  }

  bool isDecimalPointEnabled() {
    return _isDoubleOperation;
  }
  
  bool _isOperator(String value) {
    return (value == CalculatorConstants.ADDITION ||
        value == CalculatorConstants.SUBTRACTION ||
        value == CalculatorConstants.MULTIPLICATION ||
        value == CalculatorConstants.DIVISION
    );
  }

  void _resetValues() {
    _isDoubleOperation = false;
    operationToPerform = "";
  }

  String calculate(String value, String textToDisplay) {
    if(value == CalculatorConstants.DECIMAL_POINT){
      _isDoubleOperation = true;
    }

    if (value == "C") {
      firstNum = 0;
      secondNum = 0;
      result = "0";
      _resetValues();
    } else if (_isOperator(value)) {
      firstNum = double.parse(textToDisplay);
      result = "0";
      operationToPerform = value;
      _isDoubleOperation = false;
    } else if (value == CalculatorConstants.EQUALS) {
      secondNum = double.parse(textToDisplay);
      result = _executeOperation(operationToPerform, firstNum, secondNum);
      _resetValues();
    } else {
      if(value == CalculatorConstants.PLUS_MINUS && !textToDisplay.startsWith("-")) {
        result = "-" + textToDisplay;
      } else if (value == CalculatorConstants.PERCENTAGE) {
        result = (double.parse(textToDisplay) / 100.0).toString();
      } else {
        if (textToDisplay == "0") {
          textToDisplay = "";
        }
        if (value == CalculatorConstants.DECIMAL_POINT) {
          value = ".";
        }
        result = textToDisplay + value;
      }
    }

    return result;
  }
}
