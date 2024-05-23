import 'package:quokka/main.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openReleaseNotes() {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'go.linwood.dev',
          pathSegments: ['quokka', applicationMinorVersion]),
      mode: LaunchMode.externalApplication);
}
