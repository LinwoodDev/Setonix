import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/services/pack.dart';

class GameObjectsDialog extends StatefulWidget {
  const GameObjectsDialog({super.key});

  @override
  State<GameObjectsDialog> createState() => _GameObjectsDialogState();
}

class _GameObjectsDialogState extends State<GameObjectsDialog> {
  late final _figuresFuture = context.read<PackService>().getFigures();

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
        breakpoint: LeapBreakpoints.compact,
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
        title: Text(AppLocalizations.of(context).objects),
        leading: IconButton.outlined(
          onPressed: () => Navigator.of(context).pop(),
          icon: const PhosphorIcon(PhosphorIconsLight.x),
        ),
        content: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  HorizontalTab(
                      label: Text(AppLocalizations.of(context).decks),
                      icon: const PhosphorIcon(PhosphorIconsLight.cards)),
                  HorizontalTab(
                      label: Text(AppLocalizations.of(context).figures),
                      icon: const PhosphorIcon(PhosphorIconsLight.square)),
                ],
              ),
              Flexible(
                child: FutureBuilder<List<PackItem<FigureDefinition>>>(
                    future: _figuresFuture, builder: _buildList),
              ),
            ],
          ),
        ));
  }

  Widget _buildList(BuildContext context,
      AsyncSnapshot<List<PackItem<GameObjectDefinition>>> snapshot) {
    final figures = snapshot.data ?? [];
    return ListView(
      shrinkWrap: true,
      children: [
        for (final figure in figures)
          ListTile(
            leading: figure.item is FigureDefinition
                ? Image.memory(
                    figure.pack.getTexture(
                            (figure.item as FigureDefinition).back.texture) ??
                        Uint8List(0),
                    width: 100,
                    height: 100,
                  )
                : null,
            title: Text(figure.id),
            subtitle: Text(figure.pack.getMetadata()?.name ?? figure.namespace),
          ),
      ],
    );
  }
}
