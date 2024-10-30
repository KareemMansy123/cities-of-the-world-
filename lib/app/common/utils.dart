import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
  String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  final uri = Uri.parse(googleMapUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open the map.';
  }
}