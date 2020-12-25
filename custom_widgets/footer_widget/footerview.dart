import 'package:anilsorgit_blog/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FooterView extends StatefulWidget {
  final List<Widget> children;
  final Color listBackgroundColor;
  final Footer footer;
  final int flex;
  FooterView({@required this.children, @required this.footer, this.flex, this.listBackgroundColor: Colors.white}) {
    if (flex != null) {
      if (this.flex > 10 || this.flex < 1) {
        throw ArgumentError('Only 1-10 Flex range is allowed');
      }
    }
  }
  @override
  FooterViewState createState() {
    return FooterViewState();
  }
}

class FooterViewState extends State<FooterView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.listBackgroundColor,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                widget.children, //All children inside Goes here including Columns , Containers, Expanded, ListViews
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: widget.flex == null ? 8 : 10 - widget.flex, // (list height) = 10 - widget.flex
                  child: Container(),
                ),
                Expanded(
                  flex: widget.flex == null ? 2 : widget.flex, // 1 - 10 integer (footer height)
                  child: widget.footer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
