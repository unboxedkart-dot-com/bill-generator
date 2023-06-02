import 'dart:io';

import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlActions {
  ApiCalls apiCalls = ApiCalls();
  final LocalRepository localRepo = LocalRepository();

  static void handleOpenUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void handleRateUs() async {
    const url = 'https://www.trustpilot.com/review/unboxedkart.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static handleOpenStore() async {
    if (Platform.isAndroid) {
      const url =
          "https://play.google.com/store/apps/details?id=com.unboxedkart";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isIOS) {
      const url = "https://apps.apple.com/us/app/appname/id1485117463";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static void sendInviteLink(String couponCode) async {
    String inviteBody =
        "Exclusive : Hey, Now you can shop on unboxedkart using my coupon code ($couponCode) and get a flat discount of Rs.500.Click here to download app unboxedkart.com/app";
    if (Platform.isAndroid) {
      String _url = "sms:?body=$inviteBody";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    } else if (Platform.isIOS) {
      String _url = "sms:&body=$inviteBody";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    }
  }

  void makePhoneCall() async {
    String usagePostUrl =
        "https://server.unboxedkart.com/usage-tracking/clicked-to-call";
    final String accessToken = await localRepo.getAccessToken();
    apiCalls.post(url: usagePostUrl, accessToken: accessToken);
    String inviteBody =
        "Hello, you can now shop using my coupon code and get a falt discount of Rs.500";
    if (Platform.isAndroid) {
      String _url = "tel:+91 8508484848";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    } else if (Platform.isIOS) {
      String _url = "tel://8508484848";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    }
  }

  static void _sendSupportMail(String subject) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@unboxedkart.com',
      query: 'subject=$subject', //add subject and body here
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
}
