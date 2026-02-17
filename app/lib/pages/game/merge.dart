import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

class MergeDialog extends StatefulWidget {
  final GlobalVectorDefinition cell;
  final CellMergeStrategy? initialStrategy;
  final int initialSpan;

  const MergeDialog({
    super.key,
    required this.cell,
    this.initialStrategy,
    this.initialSpan = 1,
  });

  @override
  State<MergeDialog> createState() => _MergeDialogState();
}

class _MergeDialogState extends State<MergeDialog> {
  late CellMergeStrategy? _strategy = widget.initialStrategy;
  late int _span = widget.initialSpan;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final bloc = context.read<WorldBloc>();

    return ResponsiveAlertDialog(
      title: Text(loc.mergeStrategy),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          DropdownMenu<String?>(
            expandedInsets: EdgeInsets.zero,
            label: Text(loc.merge),
            initialSelection: switch (_strategy) {
              StackedCellMergeStrategy() => 'stacked',
              DistributeCellMergeStrategy() => 'distribute',
              _ => null,
            },
            onSelected: (value) {
              setState(() {
                if (value == 'stacked') {
                  _strategy = const StackedCellMergeStrategy();
                } else if (value == 'distribute') {
                  _strategy = const DistributeCellMergeStrategy();
                } else {
                  _strategy = null;
                }
              });
            },
            dropdownMenuEntries: [
              DropdownMenuEntry(value: null, label: loc.none),
              DropdownMenuEntry(value: 'stacked', label: loc.stacked),
              DropdownMenuEntry(value: 'distribute', label: loc.distribute),
            ],
          ),
          if (_strategy != null && _strategy is! MergedCellStrategy) ...[
            const SizedBox(height: 16),
            ExactSlider(
              label: loc.span,
              value: _span.toDouble(),
              min: 1,
              max: 10,
              divide: true,
              fractionDigits: 0,
              onChanged: (value) {
                setState(() {
                  _span = value.toInt();
                });
              },
            ),
          ],
          if (_strategy is StackedCellMergeStrategy) ...[
            const SizedBox(height: 16),
            ExactSlider(
              label: '${loc.visiblePercentage} (%)',
              value: (_strategy as StackedCellMergeStrategy).visiblePercentage
                  .toDouble(),
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _strategy = (_strategy as StackedCellMergeStrategy).copyWith(
                    visiblePercentage: value.toInt(),
                  );
                });
              },
            ),
          ],
          if (_strategy is DistributeCellMergeStrategy) ...[
            const SizedBox(height: 16),
            ExactSlider(
              label: loc.maxCards,
              value: (_strategy as DistributeCellMergeStrategy).maxCards
                  .toDouble(),
              min: 1,
              max: 20,
              divide: true,
              fractionDigits: 0,
              onChanged: (value) {
                setState(() {
                  _strategy = (_strategy as DistributeCellMergeStrategy)
                      .copyWith(maxCards: value.toInt());
                });
              },
            ),
            SwitchListTile(
              title: Text(loc.fillVariableSpace),
              value:
                  (_strategy as DistributeCellMergeStrategy).fillVariableSpace,
              onChanged: (value) {
                setState(() {
                  _strategy = (_strategy as DistributeCellMergeStrategy)
                      .copyWith(fillVariableSpace: value);
                });
              },
            ),
          ],
          if (_strategy != null && _strategy is! MergedCellStrategy) ...[
            SwitchListTile(
              title: Text(loc.reverse),
              value: _strategy is LayoutCellMergeStrategy
                  ? (_strategy as LayoutCellMergeStrategy).reverse
                  : false,
              onChanged: (value) {
                setState(() {
                  final s = _strategy;
                  if (s is StackedCellMergeStrategy) {
                    _strategy = s.copyWith(reverse: value);
                  } else if (s is DistributeCellMergeStrategy) {
                    _strategy = s.copyWith(reverse: value);
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            SegmentedButton<CellMergeDirection>(
              segments: [
                ButtonSegment(
                  value: CellMergeDirection.horizontal,
                  label: Text(loc.horizontal),
                ),
                ButtonSegment(
                  value: CellMergeDirection.vertical,
                  label: Text(loc.vertical),
                ),
              ],
              selected: {_strategy?.direction ?? CellMergeDirection.vertical},
              onSelectionChanged: (value) {
                setState(() {
                  _strategy = _strategy?.copyWith(direction: value.first);
                });
              },
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            bloc.process(
              CellMergeStrategyChanged(widget.cell, _strategy, span: _span),
            );
            Navigator.of(context).pop();
          },
          child: Text(loc.save),
        ),
      ],
    );
  }
}
