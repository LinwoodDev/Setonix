import 'package:quokka_server/quokka_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

Future<void> onLoad(QuokkaServer server) async {
  print("on load was called");
  server.eventSystem
    ..on<UserJoined>().listen((e) {
      e.sendEvent(DialogOpened(GameDialog(
        id: "joinDialog",
        title: "Please login",
      )
          .textField("Username", id: "username")
          .textField(
            "Password",
            id: "password",
            password: true,
          )
          .action(GameDialogButton("Login", id: "login"))
          .action(GameDialogButton("Register", id: "register"))));
    })
    ..on<DialogCloseRequest>().listen((e) {
      final event = e.clientEvent;
      if (event.id == "joinDialog") {
        if (event.value?.buttonPressed == "login") {
          print("successfully logged in");
        } else {
          e.cancel();
        }
      }
    })
    ..on<MessageRequest>().listen((e) {
      final event = e.clientEvent;
      if (event.message == "apple") {
        e.cancel();
      }
    });
}