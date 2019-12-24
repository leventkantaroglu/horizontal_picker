import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizantalPicker(
              minValue: 0,
              maxValue: 10,
              divisions: 10,
              onChanged: (value) {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizantalPicker(
              minValue: 0,
              maxValue: 10,
              divisions: 10,
              suffix: " \u00b0C",
              showCursor: false,
              backgroundColor: Colors.lightBlue.shade50,
              activeItemTextColor: Colors.blue.shade800,
              passiveItemsTextColor: Colors.blue.shade300,
              onChanged: (value) {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizantalPicker(
              minValue: -10,
              maxValue: 50,
              divisions: 600,
              suffix: " cm",
              showCursor: false,
              backgroundColor: Colors.grey.shade900,
              activeItemTextColor: Colors.white,
              passiveItemsTextColor: Colors.amber,
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }
}
