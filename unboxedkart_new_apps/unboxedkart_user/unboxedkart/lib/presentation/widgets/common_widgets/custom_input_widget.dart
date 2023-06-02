import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CustomInputWidget extends StatelessWidget {
  final String placeHolderText;
  final Function customFunction;
  final bool isInt;
  final int minLength;
  final int maxLength;
  final Color cursorColor;
  final Color textColor;
  final String prefixText;
  final bool hasPrefix;
  final TextEditingController textController;
  final bool readOnly;
  final int minLines;

  const CustomInputWidget({Key key, this.isInt = false,
      this.maxLength,
      this.customFunction,
      this.minLength,
      this.placeHolderText,
      this.textController,
      this.prefixText,
      this.hasPrefix = false,
      this.textColor = Colors.black,
      this.cursorColor = Colors.black,
      this.readOnly = false,
      this.minLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
           
           
          color: Color(0xFFF0F0F0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            onSubmitted: (val) {
              customFunction != null ? customFunction(val) : null;
            },
            maxLines: 10,
            minLines: minLines,
            readOnly: readOnly,
            inputFormatters: isInt
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : <TextInputFormatter>[],
            prefix: hasPrefix
                ? CustomSizedTextBox(
                    fontSize: 18,
                    textContent: prefixText,
                    isBold: true,
                    color: Colors.black,
                  )
                : const SizedBox(),
            placeholder: placeHolderText,
            controller: textController,
            maxLength: maxLength,
            cursorColor: cursorColor,
            keyboardType: isInt ? TextInputType.number : TextInputType.text,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'T MS',
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            decoration: const BoxDecoration(
                 
                 
                ),
          ),
        ),
      ),
    );
  }
}
