import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/bloc/settings.dart';
import 'package:quokka/widgets/search.dart';

class AddConnectDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddConnectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).connect),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).connectNote),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).address,
              filled: true,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).goNamed('connect', queryParameters: {
              'address': _controller.text,
            });
          },
          label: Text(AppLocalizations.of(context).connect),
          icon: const Icon(PhosphorIconsLight.link),
        ),
      ],
    );
  }
}

class ConnectDialog extends StatefulWidget {
  const ConnectDialog({super.key});

  @override
  State<ConnectDialog> createState() => _ConnectDialogState();
}

class _ConnectDialogState extends State<ConnectDialog> {
  int _selectedIndex = 0;
  bool _isMobileOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    final servers = List.generate(10, (index) => 'Server ${index + 1}');
    final currentIndex = _selectedIndex;
    final detailsChildren = [
      const ListTile(
        title: Text('Description'),
        subtitle: Text(
          '''Labore commodo amet nisi ad ad aliquip minim. Do minim eiusmod sunt pariatur ullamco mollit nulla consequat enim Lorem deserunt amet. Velit cupidatat officia elit consectetur cillum culpa sunt pariatur magna cupidatat culpa. Occaecat ad mollit qui laboris do nostrud.
      
      Ad id adipisicing sunt laboris mollit deserunt id adipisicing culpa. Consequat amet ea velit culpa quis nostrud ullamco ipsum aliquip nostrud labore ipsum irure. Proident aliquip nulla labore aliquip tempor minim velit excepteur ipsum incididunt. Dolore tempor officia voluptate ipsum. Et occaecat deserunt sint id incididunt nisi duis commodo elit pariatur magna voluptate. Id incididunt minim consequat irure laboris culpa laborum ipsum. Dolor fugiat laborum dolor sint adipisicing fugiat.
      
      Lorem ullamco laboris do proident occaecat mollit aliquip minim. Do irure consectetur ut do laborum deserunt aliquip dolore consectetur eu. Cupidatat consequat ea occaecat reprehenderit minim voluptate fugiat cillum do labore in. Ullamco eiusmod occaecat eu voluptate elit cupidatat non proident. Reprehenderit Lorem elit est commodo in duis Lorem sunt esse.
      
      Nisi sunt irure consectetur officia occaecat. Elit do consequat sit laboris laboris sunt est ex. Amet laboris aliqua nisi anim incididunt pariatur ex. Duis eiusmod Lorem aliqua minim eiusmod laborum sit nulla. Officia eu cupidatat veniam ad mollit sint consectetur laboris elit ipsum. Laborum officia non in aute ut voluptate Lorem culpa id labore qui ea minim ex.''',
        ),
      ),
    ];
    final playButton = SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FilledButton.icon(
              icon: const Icon(PhosphorIconsLight.play),
              label: Text(AppLocalizations.of(context).play),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 8),
          Center(
            child: IconButton.outlined(
              icon: const Icon(PhosphorIconsLight.heart),
              selectedIcon: const Icon(PhosphorIconsFill.heart),
              onPressed: () {},
              isSelected: true,
            ),
          ),
        ],
      ),
    );
    final listView = ListView.builder(
      itemCount: servers.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(servers[index]),
        onTap: () {
          setState(() {
            _selectedIndex = index;
            _isMobileOpen = isMobile;
          });
          if (isMobile) {
            showLeapBottomSheet(
              context: context,
              titleBuilder: (context) => Text(servers[_selectedIndex]),
              childrenBuilder: (context) => [
                ...detailsChildren,
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: playButton,
                ),
              ],
            ).then((_) {
              if (mounted) setState(() => _isMobileOpen = false);
            });
          }
        },
        selected: currentIndex == index && (!isMobile || _isMobileOpen),
      ),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            servers[currentIndex],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView(
            children: detailsChildren,
          ),
        ),
        const SizedBox(height: 16),
        playButton,
      ],
    );
    return BlocBuilder<SettingsCubit, QuokkaSettings>(
        buildWhen: (previous, current) =>
            previous.showConnectOfficial != current.showConnectOfficial ||
            previous.showConnectCustom != current.showConnectCustom ||
            previous.showConnectOnlyFavorites !=
                current.showConnectOnlyFavorites,
        builder: (context, settings) {
          return ResponsiveAlertDialog(
            title: Text(AppLocalizations.of(context).connect),
            leading: IconButton.outlined(
              icon: const Icon(PhosphorIconsLight.x),
              onPressed: () => Navigator.of(context).pop(),
            ),
            constraints: const BoxConstraints(
              maxWidth: LeapBreakpoints.expanded,
              maxHeight: 700,
            ),
            content: Column(
              children: [
                RowSearchView(children: [
                  InputChip(
                    label: Text(AppLocalizations.of(context).official),
                    avatar: const Icon(PhosphorIconsLight.star),
                    showCheckmark: false,
                    selected: settings.showConnectOfficial,
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .changeShowConnectOfficial(
                            !settings.showConnectOfficial),
                  ),
                  InputChip(
                    label: Text(AppLocalizations.of(context).custom),
                    avatar: const Icon(PhosphorIconsLight.puzzlePiece),
                    showCheckmark: false,
                    selected: settings.showConnectCustom,
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .changeShowConnectCustom(!settings.showConnectCustom),
                  ),
                  InputChip(
                    label: Text(AppLocalizations.of(context).onlyFavorites),
                    avatar: const Icon(PhosphorIconsLight.listHeart),
                    showCheckmark: false,
                    selected: settings.showConnectOnlyFavorites,
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .changeShowConnectOnlyFavorites(
                            !settings.showConnectOnlyFavorites),
                  ),
                ]),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: listView),
                      if (!isMobile) ...[
                        const VerticalDivider(),
                        Expanded(child: details),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
