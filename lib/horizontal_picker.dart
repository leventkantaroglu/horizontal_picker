import 'dart:math';

import 'package:flutter/material.dart';

enum InitialPosition { start, center, end }

class HorizantalPicker extends StatefulWidget {
  final double minValue, maxValue;
  final int divisions;
  final Function(double) onChanged;
  final InitialPosition initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String suffix;

  HorizantalPicker(
      {required this.minValue,
      required this.maxValue,
      required this.divisions,
      required this.onChanged,
      this.initialPosition = InitialPosition.center,
      this.backgroundColor = Colors.white,
      this.showCursor = true,
      this.cursorColor = Colors.red,
      this.activeItemTextColor = Colors.blue,
      this.passiveItemsTextColor = Colors.grey,
      this.suffix = "",})
      : assert(minValue < maxValue);

  @override
  _HorizantalPickerState createState() => _HorizantalPickerState();
}

class _HorizantalPickerState extends State<HorizantalPicker> {
  List<double> valueList = [];
  late FixedExtentScrollController _scrollController;
  late int curItem;

  int selectedFontSize = 14;
  List<Map> valueMap = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.divisions; i++) {
      valueMap.add({
        "value": widget.minValue +
            ((widget.maxValue - widget.minValue) / widget.divisions) * i,
        "fontSize": 14.0,
        "color": widget.passiveItemsTextColor,
      });
    }
    setScrollController();
  }

  setScrollController() {
    int initialItem;
    switch (widget.initialPosition) {
      case InitialPosition.start:
        initialItem = 0;
        break;
      case InitialPosition.center:
        initialItem = (valueMap.length ~/ 2);
        break;
      case InitialPosition.end:
        initialItem = valueMap.length - 1;
        break;
    }

    _scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    // _scrollController.jumpToItem(curItem);
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(20),
      height: 100,
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
          children: <Widget>[
            RotatedBox(
              quarterTurns: 3,
              child: ListWheelScrollView(
                  controller: _scrollController,
                  itemExtent: 60,
                  onSelectedItemChanged: (item) {
                    curItem = item;
                    setState(() {
                      int decimalCount = 1;
                      num fac = pow(10, decimalCount);
                      valueMap[item]["value"] =
                          (valueMap[item]["value"] * fac).round() / fac;
                      widget.onChanged(valueMap[item]["value"]);
                      for (var i = 0; i < valueMap.length; i++) {
                        if (i == item) {
                          valueMap[item]["color"] = widget.activeItemTextColor;
                          valueMap[item]["fontSize"] = 15.0;
                          valueMap[item]["hasBorders"] = true;
                        } else {
                          valueMap[i]["color"] = widget.passiveItemsTextColor;
                          valueMap[i]["fontSize"] = 14.0;
                          valueMap[i]["hasBorders"] = false;
                        }
                      }
                    });
                    setState(() {});
                  },
                  children: valueMap.map((Map curValue) {
                    return ItemWidget(
                        curValue, widget.backgroundColor, widget.suffix);
                  }).toList()),
            ),
            Visibility(
              visible: widget.showCursor,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: widget.cursorColor.withOpacity(0.3)),
                  width: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Map curItem;
  final Color backgroundColor;
  final String suffix;

  ItemWidget(this.curItem, this.backgroundColor, this.suffix);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late List<String> textParts;
  late String leftText, rightText;

  @override
  void initState() {
    super.initState();
    int decimalCount = 1;
    num fac = pow(10, decimalCount);

    var mtext = ((widget.curItem["value"] * fac).round() / fac).toString();
    textParts = mtext.split(".");
    leftText = textParts.first;
    rightText = textParts.last;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "|",
              style: TextStyle(fontSize: 8, color: widget.curItem["color"]),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  leftText,
                  style: TextStyle(
                      fontSize: widget.curItem["fontSize"],
                      color: widget.curItem["color"],
                      fontWeight:
                          rightText == "0" ? FontWeight.w800 : FontWeight.w400),
                ),
                Text(
                  rightText == "0" ? "" : ".",
                  style: TextStyle(
                    fontSize: widget.curItem["fontSize"] - 3,
                    color: widget.curItem["color"],
                  ),
                ),
                Text(
                  rightText == "0" ? "" : rightText,
                  style: TextStyle(
                      fontSize: widget.curItem["fontSize"] - 3,
                      color: widget.curItem["color"]),
                ),
                (widget.suffix.isEmpty)
                    ? SizedBox()
                    : Text(
                        widget.suffix,
                        style: TextStyle(
                            fontSize: widget.curItem["fontSize"],
                            color: widget.curItem["color"]),
                      )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "|",
              style: TextStyle(fontSize: 8, color: widget.curItem["color"]),
            ),
          ],
        ),
      ),
    );
  }
}
