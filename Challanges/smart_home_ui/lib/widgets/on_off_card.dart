import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnOffCard extends StatefulWidget {
  final bool isOn;
  final Widget icon;
  final String title;
  final String onLabel;
  final String offLabel;

  const OnOffCard({
    Key key,
    @required this.isOn,
    @required this.icon,
    @required this.title,
    @required this.onLabel,
    @required this.offLabel,
  }) : super(key: key);

  @override
  _OnOffCardState createState() => _OnOffCardState();
}

class _OnOffCardState extends State<OnOffCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.icon,
              Platform.isAndroid
                  ? Transform.scale(
                      scale: 1,
                      child: Switch(
                        value: widget.isOn,
                        onChanged: (isOn) {},
                      ),
                    )
                  : Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                        value: widget.isOn,
                        onChanged: (isOn) {},
                      ),
                    ),
            ],
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            widget.isOn ? widget.onLabel : widget.offLabel,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
