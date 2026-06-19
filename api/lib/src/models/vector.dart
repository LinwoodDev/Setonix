import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';

import '../services/asset.dart';

part 'vector.mapper.dart';

@MappableClass(hook: VectorDefinitionHook())
class VectorDefinition with VectorDefinitionMappable {
  final int x, y;

  const VectorDefinition(this.x, this.y);

  factory VectorDefinition.fromDisplay(String displayString) {
    final parts = displayString
        .replaceAll('(', '')
        .replaceAll(')', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    final x = int.parse(parts[0]);
    final y = int.parse(parts[1]);
    return VectorDefinition(x, y);
  }

  static const zero = VectorDefinition(0, 0);
  static const one = VectorDefinition(1, 1);

  String toDisplayString() => '($x, $y)';

  VectorDefinition operator +(VectorDefinition other) =>
      VectorDefinition(x + other.x, y + other.y);
  VectorDefinition operator -(VectorDefinition other) =>
      VectorDefinition(x - other.x, y - other.y);

  bool inBounds(VectorDefinition first, VectorDefinition last) {
    final minX = min(first.x, last.x);
    final maxX = max(first.x, last.x);
    final minY = min(first.y, last.y);
    final maxY = max(first.y, last.y);
    return x >= minX && x <= maxX && y >= minY && y <= maxY;
  }
}

class VectorDefinitionHook extends MappingHook {
  const VectorDefinitionHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is Iterable) {
      return VectorDefinition(value.first as int, value.last as int);
    }
    if (value is! String) {
      return value;
    }
    return VectorDefinition.fromDisplay(value);
  }

  @override
  Object? beforeEncode(Object? value) {
    if (value is! VectorDefinition) {
      return value;
    }
    return value.toDisplayString();
  }
}

@MappableClass()
class GlobalVectorDefinition with GlobalVectorDefinitionMappable {
  final String table;
  final VectorDefinition position;

  GlobalVectorDefinition(this.table, int x, int y)
    : position = VectorDefinition(x, y);

  GlobalVectorDefinition.fromLocal(this.table, this.position);

  int get x => position.x;
  int get y => position.y;
}

@MappableClass(hook: ItemLocationHook())
class ItemLocation with ItemLocationMappable {
  final String namespace, id;

  ItemLocation(this.namespace, this.id);
  factory ItemLocation.fromString(String location, [String? namespace]) {
    namespace ??= kCorePackId;
    final splitted = location.split(':');
    if (splitted.length < 2) {
      return ItemLocation(namespace, splitted[0]);
    }
    return ItemLocation(splitted[0], splitted[1]);
  }

  bool get isEmpty => namespace.isEmpty && id.isEmpty;

  @override
  String toString() => namespace.isEmpty ? id : '$namespace:$id';
}

class ItemLocationHook extends MappingHook {
  final bool nullOnEmpty;

  const ItemLocationHook({this.nullOnEmpty = true});

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return ItemLocation.fromString(value).toMap();
    }
    return value;
  }

  @override
  Object? afterEncode(Object? value) {
    if (value is ItemLocation) {
      if (value.isEmpty && nullOnEmpty) {
        return null;
      }
    }
    return value;
  }
}
