import 'dart:math';

import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final Map curItem;
  final Color backgroundColor;
  final String suffix;

  const ItemWidget(
    this.curItem,
    this.backgroundColor,
    this.suffix, {
    Key? key,
  }) : super(key: key);

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
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
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
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: leftText,
                      style: TextStyle(
                          fontSize: widget.curItem["fontSize"],
                          color: widget.curItem["color"],
                          fontWeight: rightText == "0"
                              ? FontWeight.w800
                              : FontWeight.w400),
                    ),
                    TextSpan(
                      text: rightText == "0" ? "" : ".",
                      style: TextStyle(
                        fontSize: widget.curItem["fontSize"] - 3,
                        color: widget.curItem["color"],
                      ),
                    ),
                    TextSpan(
                      text: rightText == "0" ? "" : rightText,
                      style: TextStyle(
                        fontSize: widget.curItem["fontSize"] - 3,
                        color: widget.curItem["color"],
                      ),
                    ),
                    TextSpan(
                      text: widget.suffix.isEmpty ? "" : widget.suffix,
                      style: TextStyle(
                        fontSize: widget.curItem["fontSize"],
                        color: widget.curItem["color"],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "|",
                style: TextStyle(fontSize: 8, color: widget.curItem["color"]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
