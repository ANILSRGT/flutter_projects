import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final Widget child;
  final double height;

  const AppBarWidget({
    Key key,
    this.margin,
    this.padding,
    this.decoration,
    this.child,
    this.height: 60,
  }) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      margin: widget.margin == null ? EdgeInsets.all(0) : widget.margin,
      padding: widget.padding == null ? EdgeInsets.all(0) : widget.padding,
      decoration: widget.decoration == null ? BoxDecoration() : widget.decoration,
      child: widget.child == null ? Container() : widget.child,
    );
  }
}
