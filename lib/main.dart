import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rail_converter/constants.dart';

final String lCYButtonText = 'Chains\nto\nYards';
final String rCYButtonText = 'Yards\nto\nChains';
final String lCSButtonText = 'Chains\nto\nSLUs';
final String rCSButtonText = 'SLUs\nto\nChains';
double input = 0;
double result = 0;
String resultUnit = '';

void main() {
  runApp(MaterialApp(home: MainPage()));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Rail Converter', style: h2TextStyle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ConverterLayout(
                    title: 'Chains / Yards',
                    hintText: 'Chains or Yards',
                    lButtonText: lCYButtonText,
                    rButtonText: rCYButtonText,
                  ),
                  ConverterLayout(
                    title: 'Chains / SLUs',
                    hintText: 'Chains or SLUs',
                    lButtonText: lCSButtonText,
                    rButtonText: rCSButtonText,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: Text(
                'Innovative Digital - 2021',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConverterButton extends StatefulWidget {
  ConverterButton({@required this.buttonText, @required this.onPressed});
  final String buttonText;
  final Function onPressed;
  @override
  _ConverterButtonState createState() => _ConverterButtonState();
}

class _ConverterButtonState extends State<ConverterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(letterSpacing: 1.5),
        ),
        color: Colors.orange,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

class ConverterLayout extends StatefulWidget {
  ConverterLayout({
    @required this.title,
    @required this.hintText,
    @required this.lButtonText,
    @required this.rButtonText,
  });

  final String title;
  final String hintText;
  final String lButtonText;
  final String rButtonText;
  @override
  _ConverterLayoutState createState() => _ConverterLayoutState();
}

class _ConverterLayoutState extends State<ConverterLayout> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Container(
      width: screenWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.title,
            style: h1TextStyle,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
              ],
              onChanged: (value) => input = double.parse(value),
              decoration: InputDecoration(
                hintText: widget.hintText,
              ),
            ),
          ), //input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConverterButton(
                buttonText: widget.lButtonText,
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  if (widget.lButtonText == lCYButtonText) {
                    setState(() {
                      chainsToYardsConversion(input);
                    });
                  } else {
                    setState(() {
                      chainsToSlusConversion();
                    });
                  }
                },
              ),
              ConverterButton(
                buttonText: widget.rButtonText,
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  if (widget.rButtonText == rCYButtonText) {
                    setState(() {
                      yardsToChainsConversion();
                    });
                  } else {
                    setState(() {
                      slusToChainsConversion();
                    });
                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                result.toStringAsFixed(1),
                style: h1TextStyle.copyWith(
                  fontSize: 50,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(resultUnit, style: h2TextStyle),
            ],
          ), // output
        ],
      ),
    );
  }
}

void chainsToYardsConversion(input) {
  resultUnit = 'Yards';
  result = input * 22.0;
}

void yardsToChainsConversion() {
  resultUnit = 'Chains';
  result = input / 22;
}

void chainsToSlusConversion() {
  resultUnit = 'SLUs';
  result = input / 0.31818182;
}

void slusToChainsConversion() {
  resultUnit = 'Chains';
  result = input * 0.31818182;
}

//TODO - get the 2 ConverterLayouts to work independently (result and input)
