import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const LoadingSpinnerWidget(
      {Key key, this.radius = 15, this.color = Colors.transparent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CupertinoActivityIndicator(
          color: Colors.blue,
          radius: radius,
        ),
      ),
    );
  }
}
