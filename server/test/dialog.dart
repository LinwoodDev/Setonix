import 'package:quokka_server/quokka_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

const testContent = """
This is a dialog

## This is a header

> This is a quote
""";

Future<void> onLoad(QuokkaServer server) async {
  print("on load was called");
  server.eventSystem.on<ObjectsMoved>().listen((e) {
    print("Listener was called, opening dialog");
    e.sendEvent(DialogOpened(
        GameDialog(id: "testDialog", title: "TestDialog", components: [
      GameDialogMarkdownComponent(testContent),
      GameDialogTextFieldComponent(
        "TestTextField",
        id: "testTextField",
        placeholder: "TestPlaceholder",
        multiline: true,
        password: true,
      ),
      GameDialogActionRowComponent([
        GameDialogButton("TestButton"),
      ]),
    ])));
  });
  server.eventSystem.on<DialogCloseRequest>().listen((e) {
    print("Dialog ${e.clientEvent.id} closed, got ${e.clientEvent.value}");
  });
}
