import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/models/ordered_item/ordered_item.model.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class OrderedItem extends StatelessWidget {
  final OrderedItemModel orderedItem;

  const OrderedItem({Key key, this.orderedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image(
                height: 60,
                width: 60,
                image: NetworkImage(orderedItem.imageUrl)),
          ),
          Expanded(
            flex: 8,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomSizedTextBox(
                  textContent: orderedItem.title,
                  fontSize: 14,
                  isBold: true),
              const SizedBox(height: 5),
              CustomSizedTextBox(
                  textContent: orderedItem.color, fontSize: 14),
              const SizedBox(height: 5),
              Row(
                children: [
                  CustomSizedTextBox(
                      textContent: '₹${orderedItem.total}',
                      fontSize: 16,
                      isBold: true),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomSizedTextBox(
                      textContent: '(Quantity : ${orderedItem.productCount})',
                      fontSize: 13,
                      isBold: true),
                ],
              ),
              const SizedBox(height: 5),
            ]),
          )
        ],
      ),
    );
  }
}
