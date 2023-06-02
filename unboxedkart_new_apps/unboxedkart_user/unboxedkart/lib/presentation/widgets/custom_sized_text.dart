import 'package:flutter/material.dart';

class CustomSizedTextBox extends StatelessWidget {
  String textContent;
  double fontSize;
  bool isBold;
  Color color;
  bool isLineThrough;
  bool addPadding;
  bool verticalPadding;
  String fontName;
  double paddingWidth;
  bool isCenter;

  CustomSizedTextBox(
      {Key key,
      this.textContent,
      this.fontSize = 16,
      this.color = Colors.black,
      this.isBold = false,
      this.isLineThrough = false,
      this.addPadding = false,
      this.isCenter = false,
      this.fontName,
      this.paddingWidth = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(addPadding ? paddingWidth : 0),
      child: Text(
        textContent ?? '',
        softWrap: true,
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
        style: TextStyle(
           
          fontFamily: fontName ?? 'T MS',
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
          color: color,
          decoration:
              isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
  }
}

class CustomTitleText extends StatelessWidget {
  final String title;

  const CustomTitleText({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSizedTextBox(
      textContent: title,
      isBold: true,
      fontSize: 16,
    );
  }
}

 
 

 

 
 
 
 
 

 
 
 
