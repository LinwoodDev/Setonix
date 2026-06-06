import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/save.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:rxdart/rxdart.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog>
    with TickerProviderStateMixin {
  late final TabController _tabController, _customTabController;
  final PageController _pageController = PageController(keepPage: true);
  final GlobalKey _pageKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController(),
      _descriptionController = TextEditingController();
  late final TypedKeyFileSystem<SetonixData> _templateSystem, _worldSystem;
  late final SetonixFileSystem _fileSystem;
  late Stream<List<FileSystemFile<SetonixData>>> _templatesStream;
  late final Future<Iterable<SetonixFile>> _packsFuture;

  String? _selectedTemplate;
  PackItem<BackgroundTranslation>? _background;
  PackItem<GameMode>? _selectedModeTemplate;
  List<String>? _selectedPacks;

  bool _infoView = false;

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<SetonixFileSystem>();
    _worldSystem = _fileSystem.worldSystem;
    _templateSystem = _fileSystem.templateSystem;
    _templatesStream = ValueConnectableStream(_loadTemplates()).autoConnect();
    _packsFuture = _fileSystem.getPacks();
    _tabController = TabController(length: 2, vsync: this);
    _customTabController = TabController(length: 2, vsync: this);
  }

  void _reloadTemplates() => setState(
    () => _templatesStream = ValueConnectableStream(
      _loadTemplates(),
    ).autoConnect(),
  );

  Stream<List<FileSystemFile<SetonixData>>> _loadTemplates() async* {
    await _templateSystem.initialize();
    yield* _templateSystem.fetchFiles();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customTabController.dispose();
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    final selections = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            HorizontalTab(
              icon: const PhosphorIcon(PhosphorIconsLight.folder),
              label: Text(AppLocalizations.of(context).templates),
            ),
            HorizontalTab(
              icon: const PhosphorIcon(PhosphorIconsLight.globe),
              label: Text(AppLocalizations.of(context).custom),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Material(
                type: MaterialType.transparency,
                child: StreamBuilder(
                  stream: _templatesStream,
                  builder: (context, snapshot) {
                    final templates = snapshot.data;
                    if (templates == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return FutureBuilder(
                      future: _loadGameModes(),
                      builder: (context, modesSnapshot) {
                        if (!modesSnapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final modes = modesSnapshot.data!;
                        if (templates.isEmpty && modes.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).noTemplates,
                            ),
                          );
                        }
                        return ListView(
                          children: [
                            ...templates.map((entry) {
                              final name = entry.pathWithoutLeadingSlash;
                              return ListTile(
                                title: Text(name),
                                trailing: MenuAnchor(
                                  builder: defaultMenuButton(),
                                  menuChildren: [
                                    MenuItemButton(
                                      leadingIcon: const Icon(
                                        PhosphorIconsLight.export,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).export,
                                      ),
                                      onPressed: () => exportData(
                                        context,
                                        entry.data!,
                                        entry.fileName,
                                      ),
                                    ),
                                    MenuItemButton(
                                      leadingIcon: const Icon(
                                        PhosphorIconsLight.trash,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).delete,
                                      ),
                                      onPressed: () async {
                                        await _templateSystem.deleteFile(
                                          entry.path,
                                        );
                                        _reloadTemplates();
                                      },
                                    ),
                                  ],
                                ),
                                selected:
                                    _selectedTemplate == name &&
                                    _selectedModeTemplate == null,
                                onTap: () => setState(() {
                                  _selectedTemplate = entry.fileName;
                                  _selectedModeTemplate = null;
                                }),
                              );
                            }),
                            ...modes
                                .sorted(
                                  (a, b) => _formatModeTemplateLabel(context, a)
                                      .compareTo(
                                        _formatModeTemplateLabel(context, b),
                                      ),
                                )
                                .map((entry) {
                                  final translations = entry.pack
                                      .getTranslationsStore(
                                        getLocale: () => Localizations.localeOf(
                                          context,
                                        ).languageCode,
                                      );
                                  final translation = translations
                                      .getModeTranslation(entry.id);

                                  return ListTile(
                                    leading: const PhosphorIcon(
                                      PhosphorIconsLight.package,
                                    ),
                                    title: Text(
                                      _formatModeTemplateLabel(context, entry),
                                    ),
                                    subtitle: Text(
                                      translation.description ??
                                          '${entry.namespace}/${entry.id}',
                                    ),
                                    selected:
                                        _selectedModeTemplate?.location ==
                                            entry.location &&
                                        _selectedTemplate == null,
                                    onTap: () => setState(() {
                                      _selectedModeTemplate = entry;
                                      _selectedTemplate = null;
                                    }),
                                  );
                                }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  TabBar.secondary(
                    tabs: [
                      HorizontalTab(
                        label: Text(AppLocalizations.of(context).packs),
                        icon: const Icon(PhosphorIconsLight.package),
                      ),
                      HorizontalTab(
                        label: Text(AppLocalizations.of(context).configuration),
                        icon: const Icon(PhosphorIconsLight.wrench),
                      ),
                    ],
                    tabAlignment: TabAlignment.center,
                    controller: _customTabController,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Material(
                      type: MaterialType.transparency,
                      child: TabBarView(
                        controller: _customTabController,
                        children: [
                          _CustomCreateView(
                            packsFuture: _packsFuture,
                            selectedPacksId: _selectedPacks,
                            onPacksSelected: (value) => setState(() {
                              _selectedPacks = value;
                              if (_background != null &&
                                  !_selectedPacks!.contains(
                                    _background!.namespace,
                                  )) {
                                _background = null;
                              }
                              if (_selectedModeTemplate != null &&
                                  !_selectedPacks!.contains(
                                    _selectedModeTemplate!.namespace,
                                  )) {
                                _selectedModeTemplate = null;
                              }
                            }),
                          ),
                          ListView(
                            children: [
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(context).background,
                                ),
                                subtitle: _background == null
                                    ? null
                                    : Text(_background!.item.name),
                                onTap: _showBackgroundPicker,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    final details = ListView(
      children: [
        Text(
          AppLocalizations.of(context).details,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            hintText: AppLocalizations.of(context).enterName,
            filled: true,
          ),
          controller: _nameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return LeapLocalizations.of(context).shouldNotEmpty;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            hintText: AppLocalizations.of(context).enterDescription,
            border: const OutlineInputBorder(),
          ),
          controller: _descriptionController,
          minLines: 3,
          maxLines: 5,
        ),
      ],
    );
    return ResponsiveAlertDialog(
      title: Text(LeapLocalizations.of(context).create),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: Form(
        key: _formKey,
        child: IndexedStack(
          index: isMobile ? 0 : 1,
          key: _pageKey,
          children: [
            PageView(
              controller: _pageController,
              children: [selections, details],
              onPageChanged: (value) =>
                  setState(() => _infoView = value.toInt() == 1),
            ),
            Row(
              children: [
                Expanded(child: selections),
                const SizedBox(width: 16),
                const VerticalDivider(),
                const SizedBox(width: 16),
                Expanded(child: details),
              ],
            ),
          ],
        ),
      ),
      headerActions: [
        IconButton(
          onPressed: () =>
              importFile(context, _fileSystem).then((_) => _reloadTemplates()),
          tooltip: AppLocalizations.of(context).import,
          icon: const Icon(PhosphorIconsLight.arrowSquareIn),
        ),
      ],
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(false),
          label: Text(AppLocalizations.of(context).cancel),
          icon: const Icon(PhosphorIconsLight.prohibit),
        ),
        if (isMobile && !_infoView) ...[
          FilledButton.icon(
            icon: const Icon(PhosphorIconsBold.arrowRight),
            label: Text(AppLocalizations.of(context).next),
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ),
        ] else ...[
          if (isMobile)
            ElevatedButton.icon(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              label: Text(AppLocalizations.of(context).back),
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              ),
            ),
          FilledButton.icon(
            onPressed: () async {
              if (!(_formKey.currentState?.validate() ?? false)) return;
              final name = _nameController.text.trim();
              final description = _descriptionController.text;
              final packs =
                  _selectedPacks ??
                  (await _packsFuture).map((e) => e.identifier).toList();
              var template =
                  _selectedTemplate != null && _tabController.index == 0
                  ? await _templateSystem.getFile(_selectedTemplate!)
                  : null;
              template ??= _selectedModeTemplate == null
                  ? SetonixData.empty().setInfo(GameInfo(packs: packs))
                  : SetonixData.fromMode(
                      _selectedModeTemplate,
                      packs: packs.toSet(),
                    );
              if (_background != null) {
                template = template.setTable(
                  template.getTableOrDefault().copyWith(
                    background: _background!.location,
                  ),
                );
              }
              template = template.setMetadata(
                FileMetadata(
                  name: name,
                  description: description,
                  type: SetonixFileType.game,
                ),
              );
              await _worldSystem.createFile(name, template);

              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
            label: Text(LeapLocalizations.of(context).create),
            icon: const Icon(PhosphorIconsLight.plus),
          ),
        ],
      ],
    );
  }

  Future<void> _showBackgroundPicker() async {
    List<PackItem<BackgroundDefinition>> backgrounds = [];
    final packs =
        _selectedPacks ??
        (await _packsFuture).map((e) => e.identifier).toList();
    for (final name in packs) {
      final pack = await _fileSystem.getPack(name);
      if (pack == null) continue;
      final backgroundItems = pack.load().getBackgroundItems(name);
      backgrounds.addAll(backgroundItems);
    }
    if (!mounted) return;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).background),
      childrenBuilder: (context) => backgrounds
          .sorted((a, b) => b.item.priority.compareTo(a.item.priority))
          .map((entry) {
            final translations = entry.pack.getTranslationsStore(
              getLocale: () => Localizations.localeOf(context).languageCode,
            );
            final translation = translations.getBackgroundTranslation(entry.id);
            return ListTile(
              title: Text(translation.name),
              subtitle: translation.description == null
                  ? null
                  : Text(translation.description!),
              onTap: () {
                setState(() {
                  _background = entry.withItem(translation);
                });
                Navigator.of(context).pop();
              },
              selected: _background?.location == entry.location,
            );
          })
          .toList(),
    );
  }

  String _formatModeTemplateLabel(
    BuildContext context,
    PackItem<GameMode> mode,
  ) {
    final packName = mode.pack.getMetadata()?.name;
    final translations = mode.pack.getTranslationsStore(
      getLocale: () => Localizations.localeOf(context).languageCode,
    );
    final modeName = translations.getModeTranslation(mode.id).name;
    if (packName == null || packName.isEmpty) {
      return modeName;
    }
    return '$packName / $modeName';
  }

  Future<List<PackItem<GameMode>>> _loadGameModes() async {
    final modes = <PackItem<GameMode>>[];
    final packs =
        _selectedPacks ??
        (await _packsFuture).map((e) => e.identifier).toList();
    for (final name in packs) {
      final pack = await _fileSystem.getPack(name);
      if (pack == null) continue;
      final data = pack.load();
      modes.addAll(
        data.getModes().map((id) => data.getModeItem(id, name)).nonNulls,
      );
    }
    return modes;
  }
}

class _CustomCreateView extends StatelessWidget {
  final Future<Iterable<SetonixFile>> packsFuture;
  final List<String>? selectedPacksId;
  final void Function(List<String>) onPacksSelected;

  const _CustomCreateView({
    required this.packsFuture,
    required this.selectedPacksId,
    required this.onPacksSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<SetonixFile>>(
      future: packsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final allPacks = snapshot.data!.toList();
        final addedPacks =
            selectedPacksId
                ?.map(
                  (e) => allPacks.firstWhereOrNull(
                    (element) => element.identifier == e,
                  ),
                )
                .nonNulls
                .toList() ??
            allPacks;
        final notAdded = allPacks
            .where((e) => !(selectedPacksId?.contains(e.identifier) ?? true))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: addedPacks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = addedPacks[index];
                  final id = item.identifier;
                  final pack = item.load();
                  return ListTile(
                    title: Text(
                      pack.getMetadata()?.name ??
                          AppLocalizations.of(context).unnamed,
                    ),
                    subtitle: Text(id),
                    key: ObjectKey(id),
                    leading: IconButton.outlined(
                      icon: const Icon(PhosphorIconsLight.minus),
                      onPressed: () {
                        final newSelected = addedPacks
                            .map((e) => e.identifier)
                            .where((e) => e != pack.identifier)
                            .toList();
                        onPacksSelected(newSelected);
                      },
                    ),
                  );
                },
                onReorderItem: (int oldIndex, int newIndex) {
                  final newSelected = addedPacks
                      .map((e) => e.identifier)
                      .toList();
                  final item = newSelected.removeAt(oldIndex);
                  newSelected.insert(newIndex, item);
                  onPacksSelected(newSelected);
                },
              ),
            ),
            SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                icon: const Icon(PhosphorIconsLight.plus),
                label: Text(AppLocalizations.of(context).addPack),
                onPressed: notAdded.isEmpty
                    ? null
                    : () {
                        showLeapBottomSheet(
                          context: context,
                          titleBuilder: (context) =>
                              Text(AppLocalizations.of(context).addPack),
                          childrenBuilder: (context) => notAdded.map((e) {
                            return ListTile(
                              title: Text(
                                e.load().getMetadata()?.name ??
                                    AppLocalizations.of(context).unnamed,
                              ),
                              subtitle: Text(e.identifier),
                              onTap: () {
                                Navigator.of(context).pop();
                                onPacksSelected([
                                  ...?selectedPacksId,
                                  e.identifier,
                                ]);
                              },
                            );
                          }).toList(),
                        );
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
