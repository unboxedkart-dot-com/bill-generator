import 'package:flutter/material.dart';

import '../custom_sized_text.dart';

class CustomRadioButton extends StatelessWidget {
  final int groupValue;
  final int buttonValue;
  final Function function;
  final String title;

  const CustomRadioButton({Key key, this.groupValue, this.buttonValue, this.function, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
         
         
         
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              value: buttonValue,
              groupValue: groupValue,
              onChanged: (val) {
                
                function();
              }),
          Expanded(
            child: CustomSizedTextBox(
              textContent: title,
              fontSize: 13,
              isBold: groupValue == buttonValue ? true : false,
            ),
          )
        ],
      ),
    );
  }
}
