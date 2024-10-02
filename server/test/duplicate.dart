import 'package:quokka_server/quokka_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

Future<void> onLoad(QuokkaServer server) async {
  print("on load was called");
  // Add your custom code here
  bool toggleCancel = false;
  // Put the event you want to listen to in the brackets
  server.eventSystem.on<ObjectsMoved>().listen((e) {
    print("Listener was called, cancel: $toggleCancel");
    // Cancel the event every second time and duplicate the objects instead
    if (toggleCancel) {
      final event = e.clientEvent;
      final table = e.getTableOrDefault(event.table);
      final cell = table.getCell(event.from);
      final objects = List<GameObject>.from(table.getCell(event.to).objects);
      for (final index in event.objects) {
        final object = cell.objects[index];
        objects.add(object);
      }
      // Send the event to all clients
      e.sendEvent(ObjectsSpawned(e.clientEvent.table, {event.to: objects}));
      // Cancel the event
      e.cancel();
    }
    toggleCancel = !toggleCancel;
  });
}