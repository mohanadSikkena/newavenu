

import 'package:flutter/material.dart';

import '../styles/colors.dart';


Future<dynamic> loadingDialog({required BuildContext context})=>showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  color: gray_1,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: Text(
                      "Loading...",
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
              ],
            ),
          );
        });