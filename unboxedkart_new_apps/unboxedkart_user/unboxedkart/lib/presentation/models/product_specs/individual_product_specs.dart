import 'package:flutter/material.dart';
import 'package:unboxedkart/models/product_details/product_details.model.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class IndividualProductSpecs extends StatelessWidget {
  final IndividualProductSpecModel individualProductSpecs;

  const IndividualProductSpecs({Key key, this.individualProductSpecs})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: individualProductSpecs.title,
            fontSize: 14,
            isBold: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: individualProductSpecs.values.length,
            itemBuilder: (BuildContext context, int index) {
              String key = individualProductSpecs.values.keys.elementAt(index);
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(key),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Text("${individualProductSpecs.values[key]}"),
                        flex: 2,
                      )
                    ],
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
