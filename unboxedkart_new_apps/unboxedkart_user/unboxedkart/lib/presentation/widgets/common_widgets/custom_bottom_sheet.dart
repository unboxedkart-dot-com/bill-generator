import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CustomBottomSheet {
  show({BuildContext context, Widget child}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Material( 
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  // color: Color(0xFFF0F0F0),
                  color: Colors.white),
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                children: [
                  SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(CupertinoIcons.clear_fill, size: 15,)),
                      )),
                  SizedBox(
                      // height: MediaQuery.of(context).size.height - 250,
                      child: child),
                ],
              ),
            ),
          );
        });
  }
}
