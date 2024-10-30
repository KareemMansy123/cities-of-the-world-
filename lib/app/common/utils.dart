import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
  final googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  final appleMapUrl = 'https://maps.apple.com/?q=$latitude,$longitude';

  final url = Platform.isIOS ? appleMapUrl : googleMapUrl;
  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open the map.';
  }
}
void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}