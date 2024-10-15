import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = context.read<WorldBloc>().state.searchTerm;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) =>
            previous.showHand != current.showHand ||
            previous.selectedCell != current.selectedCell ||
            previous.showDuplicates != current.showDuplicates,
        builder: (context, state) {
          if (!state.showHand || state.selectedCell != null) return SizedBox();
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: LeapBreakpoints.compact),
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(4),
                child: Row(children: [
                  Expanded(
                    child: SearchBar(
                      leading: const Icon(PhosphorIconsLight.magnifyingGlass),
                      hintText: AppLocalizations.of(context).search,
                      autoFocus: true,
                      onChanged: (value) => context
                          .read<WorldBloc>()
                          .add(SearchTermChanged(value)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(PhosphorIconsLight.stack),
                    selectedIcon: const Icon(PhosphorIconsFill.stack),
                    tooltip: AppLocalizations.of(context).showDuplicates,
                    isSelected: state.showDuplicates,
                    onPressed: () => context
                        .read<WorldBloc>()
                        .add(ShowDuplicatesChanged.toggle()),
                  )
                ]),
              )),
            ),
          );
        });
  }
}
