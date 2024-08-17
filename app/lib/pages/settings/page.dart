import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quokka/pages/settings/data.dart';

import 'general.dart';
import 'personalization.dart';

enum SettingsView {
  general,
  data,
  personalization;

  bool get isEnabled => true;

  String getLocalizedName(BuildContext context) => switch (this) {
        SettingsView.general => AppLocalizations.of(context).general,
        SettingsView.data => AppLocalizations.of(context).data,
        SettingsView.personalization =>
          AppLocalizations.of(context).personalization,
      };

  IconGetter get icon => switch (this) {
        SettingsView.general => PhosphorIcons.gear,
        SettingsView.data => PhosphorIcons.database,
        SettingsView.personalization => PhosphorIcons.monitor,
      };
  String get path => '/settings/$name';
}

class SettingsPage extends StatefulWidget {
  final bool isDialog;
  final SettingsView view;

  const SettingsPage({
    super.key,
    this.isDialog = false,
    this.view = SettingsView.general,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsView _view = SettingsView.general;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _view = widget.view;
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: widget.isDialog ? Colors.transparent : null,
        child: LayoutBuilder(builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          var navigation = Column(mainAxisSize: MainAxisSize.min, children: [
            Header(
              title: Text(AppLocalizations.of(context).settings),
              leading: IconButton.outlined(
                icon: const PhosphorIcon(PhosphorIconsLight.x),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Flexible(
              child: Material(
                color: widget.isDialog ? Colors.transparent : null,
                child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children: [
                      ...SettingsView.values
                          .where((e) => e.isEnabled)
                          .map((view) {
                        final selected = _view == view && !isMobile;
                        void navigateTo() {
                          if (isMobile) {
                            context.push(view.path);
                          } else {
                            setState(() {
                              _view = view;
                            });
                          }
                        }

                        return ListTile(
                          leading: PhosphorIcon(view.icon(selected
                              ? PhosphorIconsStyle.fill
                              : PhosphorIconsStyle.light)),
                          title: Text(view.getLocalizedName(context)),
                          onTap: navigateTo,
                          selected: selected,
                        );
                      }),
                    ]),
              ),
            )
          ]);
          if (isMobile) {
            return navigation;
          }
          final content = switch (_view) {
            SettingsView.general => const GeneralSettingsPage(inView: true),
            SettingsView.data => const DataSettingsPage(inView: true),
            SettingsView.personalization =>
              const PersonalizationSettingsPage(inView: true),
          };
          return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(width: 300, child: navigation),
            Expanded(child: content),
          ]);
        }),
      ),
    );
  }
}
