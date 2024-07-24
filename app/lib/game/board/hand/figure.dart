import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';

class FigureDefinitionHandItem
    extends HandItem<(PackItem<FigureDefinition>, String?)> {
  FigureDefinitionHandItem({required super.item});

  @override
  String get label => item.$2 ?? item.$1.id;
}
