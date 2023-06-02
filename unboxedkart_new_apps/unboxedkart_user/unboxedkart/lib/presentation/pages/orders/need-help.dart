import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_radio_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpPage extends StatefulWidget {
  final String orderId;
  final String orderNumber;

  const NeedHelpPage({Key key, this.orderId, this.orderNumber})
      : super(key: key);

  @override
  State<NeedHelpPage> createState() => _NeedHelpPageState();
}

class _NeedHelpPageState extends State<NeedHelpPage> {
  List<String> helpReasons = [
    "I didn't received my invoice",
    "Where is my order",
    "I would like to change the pickup store/delivery details",
    "I would to change my pickup timings",
  ];

  int groupValue;
  TextEditingController contentController = TextEditingController();

  void _sendSupportMail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@unboxedkart.com',
      query: 'subject=${helpReasons[groupValue]}',
    );

    var url = params.toString();
    var convertedUrl = Uri.parse(url);
    url.replaceAll("", "%20");
    if (await canLaunchUrl(convertedUrl)) {
       
      await launchUrl(convertedUrl);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(title: 'Unboxedkart support'),
      ),
      bottomSheet: CustomBottomButton(
        title: 'Submit request',
        function: () {
          if (groupValue != null) {
            _sendSupportMail();
          }
        },
      ),
      body: ElevatedContainer(
        elevation: 0,
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomSizedTextBox(
              addPadding: true,
              textContent: "Reason for contacting ",
              isBold: true,
            ),
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: helpReasons.length,
                itemBuilder: (context, index) {
                  return CustomRadioButton(
                    groupValue: groupValue,
                    buttonValue: index,
                    title: helpReasons[index],
                    function: () {
                      setState(() {
                        groupValue = index;
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
