import 'package:web/web.dart' as web;

void report(String message) {
  final output = web.document.createElement('pre');
  output.id = 'runtime-result';
  output.textContent = message;
  web.document.body!.appendChild(output);
}
