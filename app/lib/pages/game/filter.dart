import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';

class GameFilterView extends StatefulWidget {
  const GameFilterView({super.key});

  @override
  State<GameFilterView> createState() => _GameFilterViewState();
}

class _GameFilterViewState extends State<GameFilterView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      buildWhen: (previous, current) =>
          previous.showHand != current.showHand ||
          previous.selectedCell != current.selectedCell ||
          previous.showDuplicates != current.showDuplicates,
      builder: (context, state) {
        if (!state.showHand || state.selectedCell != null) return SizedBox();
        return SafeArea(
          minimum: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchBar(
                          leading: const Icon(
                            PhosphorIconsLight.magnifyingGlass,
                          ),
                          hintText: AppLocalizations.of(context).search,
                          onChanged: (value) => context.read<WorldBloc>().add(
                            SearchTermChanged(value),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIconsLight.stack),
                        selectedIcon: const Icon(PhosphorIconsFill.stack),
                        tooltip: AppLocalizations.of(context).showDuplicates,
                        isSelected: state.showDuplicates,
                        onPressed: () => context.read<WorldBloc>().add(
                          ShowDuplicatesChanged.toggle(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIconsLight.x),
                        tooltip: AppLocalizations.of(context).close,
                        onPressed: () => context.read<WorldBloc>().process(
                          HandChanged.toggle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
