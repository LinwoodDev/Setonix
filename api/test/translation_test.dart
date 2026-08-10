import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  test('role and permission translations use locale and English fallback', () {
    final store = TranslationsStore(
      getLocale: () => 'de',
      translations: [
        MapEntry(
          'en',
          PackTranslation(
            roles: {'dealer': RoleTranslation(name: 'Dealer')},
            permissions: {'deal': PermissionTranslation(name: 'Deal cards')},
          ),
        ),
        MapEntry(
          'de',
          PackTranslation(roles: {'dealer': RoleTranslation(name: 'Geber')}),
        ),
      ],
    );

    expect(store.getRoleTranslation('dealer').name, 'Geber');
    expect(store.getPermissionTranslation('deal').name, 'Deal cards');
    expect(
      store.getPermissionTranslation('shuffle', fallback: 'Shuffle').name,
      'Shuffle',
    );
  });
}
