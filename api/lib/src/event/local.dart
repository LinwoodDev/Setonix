part of 'event.dart';

@MappableClass()
abstract class LocalWorldEvent extends WorldEvent
    with LocalWorldEventMappable
    implements PlayableWorldEvent {}
