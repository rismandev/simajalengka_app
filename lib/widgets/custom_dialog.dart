import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simajalengka_app/common/navigation.dart';

customDialog(BuildContext context) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Segera hadir!'),
          content: Text('Fitur ini akan segera hadir!'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigation.back();
              },
              child: Text('Oke'),
            ),
          ],
        );
      },
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Segera hadir!'),
          content: Text('Fitur ini akan segera hadir!'),
          actions: [
            CupertinoDialogAction(
              child: Text('Oke'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
