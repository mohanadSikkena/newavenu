

import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/loading_dialog.dart';
import 'dynamic_helper.dart';

class LauncherHelper{

  static Future<void>launchWhatsapp({
    required BuildContext context,
    required String category,
    required int id
  })async{
    loadingDialog(context: context);
    HelperClass helperClass = HelperClass();
    // 'resail'
    String message = await helperClass
        .createDynamicLink(
        category: category,
        id: id)
        .then((value) {
      Navigator.pop(context);
      return value;
    });
    bool canLaunchWhatsapp =
    await canLaunchUrl(
        Uri.parse('whatsapp://send'));
    if (canLaunchWhatsapp) {
      await launchUrl(Uri.parse(
          "whatsapp://send?phone=" +
              PropertiesCubit.get(context).phone +
              "&text=$message"));
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
}