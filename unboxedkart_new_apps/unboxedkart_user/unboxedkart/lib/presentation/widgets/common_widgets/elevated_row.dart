import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';

class ElevatedRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const ElevatedRow({Key key, this.title, this.subTitle, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
        elevation: 0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Text(
              subTitle ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ));
  }
}
