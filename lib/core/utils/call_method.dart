import 'package:url_launcher/url_launcher.dart';

void phoneCallMethod(String phone) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phone,
  );
  await launchUrl(launchUri);
}