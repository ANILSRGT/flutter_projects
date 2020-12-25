import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final Color backgroundColor;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Widget child;
  Footer({this.backgroundColor, this.alignment, this.padding, @required this.child});
  @override
  State createState() => FooterState();
}

class FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor == null ? Colors.grey.shade200 : widget.backgroundColor,
      child: Align(
        alignment: widget.alignment == null ? Alignment.bottomCenter : widget.alignment,
        child: Padding(
          padding: widget.padding == null ? EdgeInsets.all(0.0) : widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
