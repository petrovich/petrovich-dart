import 'package:test/test.dart';
import 'package:petrovich/petrovich.dart';

main() {
  test('have gender androgynous', () {
    return expect(Petrovich.GENDER_ANDROGYNOUS, new Petrovich().gender);
  });

  test('have gender female', () {
    return expect(Petrovich.GENDER_FEMALE, new Petrovich(Petrovich.GENDER_FEMALE).gender);
  });

  test('have gender male', () {
    return expect(Petrovich.GENDER_MALE, new Petrovich(Petrovich.GENDER_MALE).gender);
  });

  test('detect male gender', () {
    return expect(Petrovich.GENDER_MALE, Petrovich.detectGender('Петрович'));
  });

  test('detect female gender', () {
    return expect(Petrovich.GENDER_FEMALE, Petrovich.detectGender('Петровна'));
  });

  test('detect androgynous gender', () {
    return expect(Petrovich.GENDER_ANDROGYNOUS, Petrovich.detectGender('Блабла'));
  });
}
