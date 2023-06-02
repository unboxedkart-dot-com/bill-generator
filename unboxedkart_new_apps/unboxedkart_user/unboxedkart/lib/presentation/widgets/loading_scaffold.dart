import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class LoadingScaffold extends StatelessWidget {
  final String title;
  final bool enableBack;

  const LoadingScaffold({Key key, this.title, this.enableBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: title,
      enableBack: true,
      child: const LoadingSpinnerWidget(),
    );
  }
}
