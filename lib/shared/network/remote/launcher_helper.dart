

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:url_launcher/url_launcher.dart';


class LauncherHelper{

  static Future<void>launchWhatsapp({
    required String msg,
    required BuildContext context

  })async{
    bool canLaunchWhatsapp =
    await canLaunchUrl(
        Uri.parse('whatsapp://send'));
    if (canLaunchWhatsapp) {
      await launchUrl(Uri.parse(
          "whatsapp://send?phone=" +
              PropertiesCubit.get(context).phone +
              "&text=$msg"));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
              'WhatsApp is not installed on your device.'),
        ),
      );
    }

  }

  static Future<void> launchFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/{your-page-id}';
    } else {
      fbProtocolUrl = 'fb://profile/100085972311601';
    }
    String fallbackUrl = 'https://www.facebook.com/NewAvenueInvestments';
    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle this as you prefer
    }
  }
static Future<void> launchInstagram() async {
  {
    const nativeUrl = "instagram://user?username=newavenueinvestment";
    const webUrl = "https://www.instagram.com/newavenueinvestment/";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else if (await canLaunchUrl(Uri.parse(webUrl))) {
      await launchUrl(Uri.parse(webUrl));
    } else {
    }
  }
  }

}