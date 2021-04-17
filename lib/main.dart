import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MainPage()));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
        backgroundColor: Colors.orange,
        title: Text(
          'Rail Converter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenHeight * 0.82,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: screenWidth,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Chains to Yards'),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Chains or Yards',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.04,
            color: Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
