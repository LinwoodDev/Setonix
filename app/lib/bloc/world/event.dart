import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'event.mapper.dart';

part 'event/server.dart';
part 'event/client.dart';
part 'event/hybrid.dart';
part 'event/local.dart';
part 'event/process.dart';

@MappableClass(discriminatorKey: 'type')
sealed class WorldEvent with WorldEventMappable {
  WorldEvent();
}

/// Events that can be processed by the event management system
/// This can be a ServerWorldEvent or a LocalWorldEvent
@MappableClass(discriminatorKey: 'type')
sealed class PlayableWorldEvent extends WorldEvent
    with PlayableWorldEventMappable {}
