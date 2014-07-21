part of petrovich;

class Petrovich {

  static const CASE_NOMENATIVE = -1;
  static const CASE_GENITIVE = 0;
  static const CASE_DATIVE = 1;
  static const CASE_ACCUSATIVE = 2;
  static const CASE_INSTRUMENTAL = 3;
  static const CASE_PREPOSITIONAL = 4;

  static const GENDER_ANDROGYNOUS = 0;
  static const GENDER_MALE = 1;
  static const GENDER_FEMALE = 2;

  Map _rules;
  int gender = GENDER_ANDROGYNOUS;

  /**
   * Constructor
   */
  Petrovich([this.gender = GENDER_ANDROGYNOUS, rulesPath = '../rules/rules.json']) {
    File rulesFile = new File(rulesPath);

    String rulesJson = rulesFile.readAsStringSync();
    _rules = JSON.decode(rulesJson);
  }

  /**
   * Detect gender by middle name
   */
  static int detectGender(String middleName) {
    switch (middleName.substring(middleName.length - 2)) {
      case 'ич':
        return GENDER_MALE;
      case 'на':
        return GENDER_FEMALE;
      default:
        return GENDER_ANDROGYNOUS;
    }
  }

}
