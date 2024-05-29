import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      const Text(
        '''Labore commodo amet nisi ad ad aliquip minim. Do minim eiusmod sunt pariatur ullamco mollit nulla consequat enim Lorem deserunt amet. Velit cupidatat officia elit consectetur cillum culpa sunt pariatur magna cupidatat culpa. Occaecat ad mollit qui laboris do nostrud.

Ad id adipisicing sunt laboris mollit deserunt id adipisicing culpa. Consequat amet ea velit culpa quis nostrud ullamco ipsum aliquip nostrud labore ipsum irure. Proident aliquip nulla labore aliquip tempor minim velit excepteur ipsum incididunt. Dolore tempor officia voluptate ipsum. Et occaecat deserunt sint id incididunt nisi duis commodo elit pariatur magna voluptate. Id incididunt minim consequat irure laboris culpa laborum ipsum. Dolor fugiat laborum dolor sint adipisicing fugiat.

Lorem ullamco laboris do proident occaecat mollit aliquip minim. Do irure consectetur ut do laborum deserunt aliquip dolore consectetur eu. Cupidatat consequat ea occaecat reprehenderit minim voluptate fugiat cillum do labore in. Ullamco eiusmod occaecat eu voluptate elit cupidatat non proident. Reprehenderit Lorem elit est commodo in duis Lorem sunt esse.

Nisi sunt irure consectetur officia occaecat. Elit do consequat sit laboris laboris sunt est ex. Amet laboris aliqua nisi anim incididunt pariatur ex. Duis eiusmod Lorem aliqua minim eiusmod laborum sit nulla. Officia eu cupidatat veniam ad mollit sint consectetur laboris elit ipsum. Laborum officia non in aute ut voluptate Lorem culpa id labore qui ea minim ex.''',
      ),
    ];
    final playButton = SizedBox(
      height: 48,
      child: FilledButton.icon(
        icon: const Icon(PhosphorIconsLight.play),
        label: Text(AppLocalizations.of(context).play),
        onPressed: () => Navigator.of(context).pop(),
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
              title: servers[_selectedIndex],
              childrenBuilder: (context) => [
                ...detailsChildren,
                const SizedBox(height: 16),
                playButton,
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
        Text(
          servers[currentIndex],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: detailsChildren,
          ),
        ),
        const SizedBox(height: 16),
        playButton,
      ],
    );
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
      content: Row(
        children: [
          Expanded(child: listView),
          if (!isMobile) ...[
            const VerticalDivider(),
            Expanded(child: details),
          ],
        ],
      ),
    );
  }
}
