import 'package:dart_mappable/dart_mappable.dart';

part "toolbar.mapper.dart";

@MappableClass()
final class GameToolbar with GameToolbarMappable {
  final bool editable;
  final List<ToolbarAction> actions;

  const GameToolbar({this.editable = true, this.actions = const []});
}

@MappableClass()
final class ToolbarAction with ToolbarActionMappable {
  final String id;
  final String label;
  final bool enabled;

  const ToolbarAction({
    required this.id,
    required this.label,
    this.enabled = true,
  });
}
