import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  const table = GameTable(
    minCell: VectorDefinition(-1, 0),
    maxCell: VectorDefinition(1, 2),
  );

  test('restricts cells to the configured inclusive range', () {
    expect(table.isRestricted, isTrue);
    expect(table.containsCell(const VectorDefinition(-1, 0)), isTrue);
    expect(table.containsCell(const VectorDefinition(1, 2)), isTrue);
    expect(table.containsCell(const VectorDefinition(-2, 0)), isFalse);
    expect(table.containsCell(const VectorDefinition(0, 3)), isFalse);
  });

  test('does not allow merges beyond a table boundary', () {
    expect(
      table.canMerge(
        const VectorDefinition(0, 1),
        CellMergeDirection.horizontal,
        2,
      ),
      isTrue,
    );
    expect(
      table.canMerge(
        const VectorDefinition(0, 1),
        CellMergeDirection.horizontal,
        3,
      ),
      isFalse,
    );
  });

  test('serializes table bounds', () {
    final decoded = GameTableMapper.fromJson(table.toJson());

    expect(decoded.minCell, const VectorDefinition(-1, 0));
    expect(decoded.maxCell, const VectorDefinition(1, 2));
  });

  test('updates table bounds through a world event', () {
    final state = WorldState(data: SetonixData.empty());

    final updated = processServerEvent(
      TableBoundsChanged(
        '',
        minCell: const VectorDefinition(0, 0),
        maxCell: const VectorDefinition(2, 2),
      ),
      state,
      signature: const [],
    ).state!;

    expect(updated.table.minCell, const VectorDefinition(0, 0));
    expect(updated.table.maxCell, const VectorDefinition(2, 2));
  });
}
