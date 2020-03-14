import 'package:flutter/material.dart';
import 'package:calculator/src/manager.dart';
import 'package:calculator/src/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CalculatorManager manager = CalculatorManager();
  String textToDisplay = '0';

  void handleClick(value) {
    if(value == CalculatorConstants.DECIMAL_POINT && this.manager.isDecimalPointEnabled()) {
      return null;
    }

    var result = this.manager.calculate(value, this.textToDisplay);
    setState(() {
      this.textToDisplay = result;
    });
  }

  Widget buildNumberButton(displayValue) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: RaisedButton(
        child: Text(displayValue,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500, color: Colors.white)
        ),
        color: Color(0xff333333),
        padding: EdgeInsets.all(24.0),
        shape: CircleBorder(),
          onPressed: () => handleClick(displayValue)
      ),
    );
  }

  Widget buildZeroButton() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: RaisedButton(
        child: Text("0",
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500, color: Colors.white)
        ),
        color: Color(0xff333333),
        padding: EdgeInsets.only(left: 84.0, right: 84.0, top: 18.0, bottom: 18.0),
        shape: StadiumBorder(),
        onPressed: () => handleClick("0"),
      ),
    );
  }

  Widget buildOperatorButton(displayValue) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
      child: MaterialButton(
        child: Text(displayValue,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600)),
        color: Colors.orange,
        padding: EdgeInsets.all(24.0),
        shape: CircleBorder(),
        onPressed: () => handleClick(displayValue),
      ),
    );
  }

  Widget buildSpecialButton(displayValue) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0, left: 6.0, right: 3.0),
      child: MaterialButton(
        child: Text(
            displayValue,
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                color: Colors.black
            )
        ),
        color: Color(0xffa5a5a5),
        padding: EdgeInsets.all(26.0),
        shape: CircleBorder(),
        onPressed: () => handleClick(displayValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.black,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 0, 12, 12),
              child: Text(textToDisplay,
                  style: TextStyle(
                    fontSize: 84.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildSpecialButton(CalculatorConstants.CLEAR),
                    buildSpecialButton(CalculatorConstants.PLUS_MINUS),
                    buildSpecialButton(CalculatorConstants.PERCENTAGE),
                    buildOperatorButton(CalculatorConstants.DIVISION),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildNumberButton("7"),
                    buildNumberButton("8"),
                    buildNumberButton("9"),
                    buildOperatorButton(CalculatorConstants.MULTIPLICATION),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildNumberButton("4"),
                    buildNumberButton("5"),
                    buildNumberButton("6"),
                    buildOperatorButton(CalculatorConstants.SUBTRACTION),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildNumberButton("1"),
                    buildNumberButton("2"),
                    buildNumberButton("3"),
                    buildOperatorButton(CalculatorConstants.ADDITION),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildZeroButton(),
                    buildNumberButton(CalculatorConstants.DECIMAL_POINT),
                    buildOperatorButton(CalculatorConstants.EQUALS),
                  ],
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
