import 'package:flutter/material.dart';

class WIndelibleFutureBuilder extends StatefulWidget {
  final Future future;
  final AsyncWidgetBuilder builder;

  const WIndelibleFutureBuilder({Key key, this.future, this.builder}) : super(key: key);

  @override
  _WIndelibleFutureBuilderState createState() => _WIndelibleFutureBuilderState();
}

class _WIndelibleFutureBuilderState extends State<WIndelibleFutureBuilder>
    with AutomaticKeepAliveClientMixin<WIndelibleFutureBuilder> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }
}
