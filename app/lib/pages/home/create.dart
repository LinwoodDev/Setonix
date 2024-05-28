import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog>
    with TickerProviderStateMixin {
  late final TabController _tabController, _customTabController;
  final PageController _pageController = PageController(keepPage: true);
  bool _infoView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _customTabController = TabController(length: 2, vsync: this);
    _pageController.addListener(() {
      setState(() {
        _infoView = _pageController.page?.toInt() == 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customTabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    return ResponsiveAlertDialog(
      title: const Text('Create'),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: Builder(builder: (context) {
        final selections = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                HorizontalTab(
                  icon: PhosphorIcon(PhosphorIconsLight.folder),
                  label: Text('Templates'),
                ),
                HorizontalTab(
                  icon: PhosphorIcon(PhosphorIconsLight.globe),
                  label: Text('Custom'),
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
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Template ${index + 1}'),
                          onTap: () => Navigator.of(context).pop(),
                        );
                      },
                    ),
                  ),
                  Column(children: [
                    TabBar.secondary(
                      tabs: const [
                        HorizontalTab(
                            label: Text('Packs'),
                            icon: Icon(PhosphorIconsLight.package)),
                        HorizontalTab(
                            label: Text('Configuration'),
                            icon: Icon(PhosphorIconsLight.wrench)),
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
                            ListView.builder(
                              itemCount: 30,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text('Custom ${index + 1}'),
                                  value: false,
                                  onChanged: (bool? value) {},
                                );
                              },
                            ),
                            ListView(
                              children: [
                                ListTile(
                                  title: const Text('Background'),
                                  subtitle: const Text('Not set'),
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                                const ListTile(
                                  title: Text('Rules'),
                                  subtitle: Text('Coming soon'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        );
        final details = ListView(
          children: [
            Text('Details', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Name', hintText: 'Enter a name', filled: true),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description',
                border: OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
            ),
          ],
        );
        return IndexedStack(
          index: isMobile ? 0 : 1,
          children: [
            PageView(
              controller: _pageController,
              children: [
                selections,
                details,
              ],
              onPageChanged: (value) => setState(() => _infoView = value == 1),
            ),
            Row(
              children: [
                Expanded(child: selections),
                const SizedBox(width: 16),
                const VerticalDivider(),
                const SizedBox(width: 16),
                Expanded(child: details),
              ],
            )
          ],
        );
      }),
      actions: [
        if (isMobile && !_infoView) ...[
          FilledButton.icon(
            icon: const Icon(PhosphorIconsBold.arrowRight),
            label: const Text('Next'),
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ),
        ] else ...[
          if (isMobile)
            ElevatedButton.icon(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              label: const Text('Back'),
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              ),
            ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            label: const Text('Create'),
            icon: const Icon(PhosphorIconsLight.plus),
          ),
        ]
      ],
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
