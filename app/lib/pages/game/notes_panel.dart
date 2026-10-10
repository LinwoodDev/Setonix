import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/pages/game/note_content.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class GameNotesPanel extends StatelessWidget {
  final VoidCallback onClose, onManage;
  final Key? readerKey;

  const GameNotesPanel({
    super.key,
    required this.onClose,
    required this.onManage,
    this.readerKey,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorldBloc, ClientWorldState>(
        buildWhen: (previous, current) =>
            previous.data != current.data ||
            previous.info.homeNote != current.info.homeNote ||
            previous.world.toolbar != current.world.toolbar,
        builder: (context, state) => GameNotesReader(
          key: readerKey,
          data: state.data,
          homeNote: state.info.homeNote,
          editable: state.world.toolbar.editable,
          actions: state.world.toolbar.actions,
          onAction: (id) => processNoteAction(context.read<WorldBloc>(), id),
          onClose: onClose,
          onManage: onManage,
        ),
      );
}

/// A persistent mobile reader that leaves the board usable while collapsed.
class GameNotesSheet extends StatefulWidget {
  static const collapsedHeight = 84.0;

  final SetonixData data;
  final String? homeNote;
  final bool editable;
  final List<ToolbarAction> actions;
  final ValueChanged<String>? onAction;
  final VoidCallback onClose, onManage;
  final Key? readerKey;

  const GameNotesSheet({
    super.key,
    required this.data,
    this.homeNote,
    this.editable = true,
    this.actions = const [],
    this.onAction,
    required this.onClose,
    required this.onManage,
    this.readerKey,
  });

  @override
  State<GameNotesSheet> createState() => _GameNotesSheetState();
}

class _GameNotesSheetState extends State<GameNotesSheet> {
  final _controller = DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final minSize = math.min(
        (GameNotesSheet.collapsedHeight +
                MediaQuery.paddingOf(context).bottom) /
            constraints.maxHeight,
        0.9,
      );
      final snapSizes = [minSize, if (minSize < 0.5) 0.5, 0.9];
      void animateTo(double size) {
        if (!_controller.isAttached) return;
        _controller.animateTo(
          size,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }

      void toggleExpanded() {
        if (!_controller.isAttached) return;
        animateTo(_controller.size <= minSize + 0.01 ? snapSizes[1] : minSize);
      }

      final dragHandle = Semantics(
        button: true,
        label: AppLocalizations.of(context).notes,
        onTap: toggleExpanded,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          excludeFromSemantics: true,
          onTap: toggleExpanded,
          child: SizedBox(
            height: 20,
            child: Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      );
      return DraggableScrollableSheet(
        controller: _controller,
        initialChildSize: minSize,
        minChildSize: minSize,
        maxChildSize: 0.9,
        snap: true,
        snapSizes: minSize < 0.5 ? const [0.5] : null,
        shouldCloseOnMinExtent: false,
        expand: false,
        builder: (context, scrollController) => Material(
          elevation: 8,
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            top: false,
            child: GameNotesReader(
              key: widget.readerKey,
              data: widget.data,
              homeNote: widget.homeNote,
              editable: widget.editable,
              actions: widget.actions,
              onAction: widget.onAction,
              onClose: widget.onClose,
              onManage: widget.onManage,
              scrollController: scrollController,
              dragHandle: dragHandle,
              headerBuilder: (child) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (details) {
                  if (!_controller.isAttached) return;
                  _controller.jumpTo(
                    (_controller.size -
                            details.delta.dy / constraints.maxHeight)
                        .clamp(minSize, 0.9),
                  );
                },
                onVerticalDragEnd: (details) {
                  if (!_controller.isAttached) return;
                  final size = _controller.size;
                  final velocity = details.primaryVelocity ?? 0;
                  final target = velocity < -300
                      ? snapSizes.firstWhere(
                          (snap) => snap > size + 0.01,
                          orElse: () => 0.9,
                        )
                      : velocity > 300
                      ? snapSizes.lastWhere(
                          (snap) => snap < size - 0.01,
                          orElse: () => minSize,
                        )
                      : snapSizes.reduce(
                          (a, b) => (a - size).abs() < (b - size).abs() ? a : b,
                        );
                  animateTo(target);
                },
                child: child,
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// The reader keeps the selected note and scroll position across live updates.
class GameNotesReader extends StatefulWidget {
  final SetonixData data;
  final String? homeNote;
  final bool editable;
  final List<ToolbarAction> actions;
  final ValueChanged<String>? onAction;
  final VoidCallback onClose, onManage;
  final ScrollController? scrollController;
  final Widget? dragHandle;
  final Widget Function(Widget)? headerBuilder;

  const GameNotesReader({
    super.key,
    required this.data,
    this.homeNote,
    this.editable = true,
    this.actions = const [],
    this.onAction,
    required this.onClose,
    required this.onManage,
    this.scrollController,
    this.dragHandle,
    this.headerBuilder,
  });

  @override
  State<GameNotesReader> createState() => _GameNotesReaderState();
}

class _GameNotesReaderState extends State<GameNotesReader> {
  final _scrollController = ScrollController();
  String? _selected;

  ScrollController get _effectiveScrollController =>
      widget.scrollController ?? _scrollController;

  void _selectNote(String? note) {
    if (note == null) return;
    if (_effectiveScrollController.hasClients) {
      _effectiveScrollController.jumpTo(0);
    }
    if (note != _selected) setState(() => _selected = note);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final notes = widget.data.getNotes().toList()..sort();
    final selected = notes.contains(_selected)
        ? _selected
        : notes.contains(widget.homeNote)
        ? widget.homeNote
        : notes.firstOrNull;
    _selected = selected;
    final selector = notes.length > 1
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: DropdownMenu<String>(
              key: ValueKey(selected),
              initialSelection: selected,
              expandedInsets: EdgeInsets.zero,
              requestFocusOnTap: false,
              label: Text(loc.notes),
              dropdownMenuEntries: notes
                  .map(
                    (note) => DropdownMenuEntry(
                      value: note,
                      label: note,
                      leadingIcon: note == widget.homeNote
                          ? const Icon(PhosphorIconsLight.house)
                          : null,
                    ),
                  )
                  .toList(),
              onSelected: _selectNote,
            ),
          )
        : null;
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.dragHandle != null) widget.dragHandle!,
        SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    notes.length == 1 ? selected! : loc.notes,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (!widget.editable)
                  Tooltip(
                    message: loc.readOnly,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(PhosphorIconsLight.lock, size: 20),
                    ),
                  ),
                if (notes.contains(widget.homeNote))
                  IconButton(
                    onPressed: () => _selectNote(widget.homeNote),
                    tooltip: loc.homePage,
                    icon: const Icon(PhosphorIconsLight.house),
                  ),
                IconButton(
                  onPressed: widget.onManage,
                  tooltip: loc.manageNotes,
                  icon: const Icon(PhosphorIconsLight.folderOpen),
                ),
                IconButton(
                  onPressed: widget.onClose,
                  tooltip: loc.close,
                  icon: const Icon(PhosphorIconsLight.x),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.headerBuilder?.call(header) ?? header,
          Expanded(
            child: CustomScrollView(
              controller: _effectiveScrollController,
              slivers: [
                const SliverToBoxAdapter(child: Divider(height: 1)),
                if (selector != null) SliverToBoxAdapter(child: selector),
                if (selected == null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(PhosphorIconsLight.files, size: 40),
                            const SizedBox(height: 12),
                            Text(
                              loc.noNotes,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonalIcon(
                              onPressed: widget.onManage,
                              icon: const Icon(PhosphorIconsLight.folderOpen),
                              label: Text(loc.manageNotes),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: GameNoteContent(
                        key: ValueKey(selected),
                        content: widget.data.getNote(selected) ?? '',
                        actions: widget.actions,
                        onAction: widget.onAction,
                        onOpenNote: (note) {
                          if (notes.contains(note)) {
                            _selectNote(note);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(loc.noteNotFound(note))),
                            );
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
