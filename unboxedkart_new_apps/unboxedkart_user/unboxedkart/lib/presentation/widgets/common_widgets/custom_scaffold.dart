import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final bool enableBack;
  final String pageTitle;
  final Widget child;
  final Widget bottomButton;
   
   

  const CustomScaffold(
      {Key key,
      this.enableBack = true,
      this.pageTitle,
      this.child,
      this.bottomButton,
       
       
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(
             
             
            enableBack: enableBack,
            title: pageTitle,
          ),
          preferredSize: const Size.fromHeight(50)),
      bottomSheet: bottomButton,
      body: child,
    );
  }
}
