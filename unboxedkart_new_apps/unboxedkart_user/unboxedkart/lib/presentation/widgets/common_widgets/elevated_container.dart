import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double width;
  final double margin;
  final bool noBorderRadius;
  final double customPadding;

  const ElevatedContainer(
      {Key key,
      this.child,
      this.elevation = 2,
      this.width,
      this.margin = 8,
      this.noBorderRadius = false,
      this.customPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(customPadding != null ? customPadding : 8.0),
      child: Material(
          color: Colors.white,
          elevation: elevation,
          shadowColor: CustomColors.backgroundGrey,
          borderRadius: BorderRadius.circular(noBorderRadius ? 0 : 15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(width: width, child: child),
          )),
    );
  }
}
