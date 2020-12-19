import 'package:flutter/material.dart';

class GecisliArkaplanContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor renk;

  const GecisliArkaplanContainer({@required this.renk, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            renk[700],
            renk[500],
            renk[200],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.6, 0.8, 1],
        ),
      ),
    );
  }
}
