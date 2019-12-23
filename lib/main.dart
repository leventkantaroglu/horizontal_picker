/*

  _      ______ _  __
 | |    |  ____| |/ /    /\
 | |    | |__  | ' /    /  \
 | |    |  __| |  <    / /\ \
 | |____| |____| . \  / ____ \
 |______|______|_|\_\/_/    \_\

  _____  ______  _____ _____ _____ _   _                     _____  _____   _____
 |  __ \|  ____|/ ____|_   _/ ____| \ | |   ___        /\   |  __ \|  __ \ / ____|
 | |  | | |__  | (___   | || |  __|  \| |  ( _ )      /  \  | |__) | |__) | (___
 | |  | |  __|  \___ \  | || | |_ | . ` |  / _ \/\   / /\ \ |  ___/|  ___/ \___ \
 | |__| | |____ ____) |_| || |__| | |\  | | (_>  <  / ____ \| |    | |     ____) |
 |_____/|______|_____/|_____\_____|_| \_|  \___/\/ /_/    \_\_|    |_|    |_____/


 */
import 'package:horizantal_picker/horizantalPicker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double minV = 1;
  Color cursorColorData = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          HorizantalPicker(
              minValue: 12,
              maxValue: 14,
              divisions: 3,
              cursorColor: cursorColorData,
              backgroundColor: Colors.white,
              suffix: "\u00b0C",
              onChanged: (value) {
                setState(() {
                  minV = value;
                });
                //print(minV.toString());
              }),
          SizedBox(
            height: 15,
          ),
          HorizantalPicker(
            minValue: minV,
            maxValue: 14,
            divisions: 20,
            backgroundColor: Colors.grey.shade900,
            showCursor: false,
            cursorColor: Colors.green,
            activeItemTextColor: Colors.yellow,
            passiveItemsTextColor: Colors.grey,
            initialPosition: InitialPosition.end,
            onChanged: (value) {
              print(minV.toString());
            },
          ),
          RaisedButton(
            child: Text("data"),
            onPressed: () {
              print(minV.toString());
              setState(() {
                cursorColorData = Colors.black;
                setState(() {
                  minV = 55;
                });
              });
            },
          ),
          SizedBox(
            height: 100,
            /*   child:  HorizantalPicker(
              minValue: 120, maxValue: 140, backgroundColor: Colors.white),
        */
          )
        ],
      ),
    );
  }
}
