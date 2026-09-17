import 'package:material_ui/material_ui.dart';
import 'package:setonix/pages/settings/input.dart';
import 'package:setonix/pages/settings/servers.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/pages/settings/data.dart';

import 'general.dart';
import 'personalization.dart';

enum SettingsView {
  general,
  data,
  personalization,
  inputs,
  servers;

  bool get isEnabled => true;

  String getLocalizedName(BuildContext context) => switch (this) {
    SettingsView.general => AppLocalizations.of(context).general,
    SettingsView.data => AppLocalizations.of(context).data,
    SettingsView.personalization => AppLocalizations.of(
      context,
    ).personalization,
    SettingsView.inputs => AppLocalizations.of(context).inputs,
    SettingsView.servers => AppLocalizations.of(context).serverLists,
  };

  IconGetter get icon => switch (this) {
    SettingsView.general => IconGetter(
      PhosphorIconsLight.gear,
      PhosphorIconsFill.gear,
    ),
    SettingsView.data => IconGetter(
      PhosphorIconsLight.database,
      PhosphorIconsFill.database,
    ),
    SettingsView.personalization => IconGetter(
      PhosphorIconsLight.monitor,
      PhosphorIconsFill.monitor,
    ),
    SettingsView.inputs => IconGetter(
      PhosphorIconsLight.keyboard,
      PhosphorIconsFill.keyboard,
    ),
    SettingsView.servers => IconGetter(
      PhosphorIconsLight.list,
      PhosphorIconsFill.list,
    ),
  };
  String get path => '/settings/$name';

  Widget buildContent({bool inView = false}) => switch (this) {
    SettingsView.general => GeneralSettingsPage(inView: inView),
    SettingsView.data => DataSettingsPage(inView: inView),
    SettingsView.personalization => PersonalizationSettingsPage(inView: inView),
    SettingsView.inputs => InputsSettingsPage(inView: inView),
    SettingsView.servers => ServersSettingsPage(inView: inView),
  };
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            var navigation = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        ...SettingsView.values.where((e) => e.isEnabled).map((
                          view,
                        ) {
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
                            leading: PhosphorIcon(
                              selected ? view.icon.fill : view.icon.light,
                            ),
                            title: Text(view.getLocalizedName(context)),
                            onTap: navigateTo,
                            selected: selected,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
            if (isMobile) {
              return navigation;
            }
            final content = _view.buildContent(inView: true);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 300, child: navigation),
                Expanded(child: content),
              ],
            );
          },
        ),
      ),
    );
  }
}
