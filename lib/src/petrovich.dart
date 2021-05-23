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

  /// Constructor
  ///
  Petrovich([this.gender = GENDER_ANDROGYNOUS, rulesPath = '../rules/rules.json']) {
    final rulesFile = File(rulesPath);

    final rulesJson = rulesFile.readAsStringSync();
    _rules = json.decode(rulesJson);
  }

  /// Detect gender by middle name
  ///
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

  ///Get gender int by string
  ///
  int _getGender(String gender) {
    switch (gender) {
      case 'male':
        return GENDER_MALE;
      case 'female':
        return GENDER_FEMALE;
      case 'androgynous':
        return GENDER_ANDROGYNOUS;
    }
    return GENDER_ANDROGYNOUS;
  }

  bool _checkGender(String gender) {
    return this.gender == _getGender(gender) || _getGender(gender) == GENDER_ANDROGYNOUS;
  }

  String _applyRule(List<String> mods, String name, int cs) {
    final to = name.length - mods[cs].allMatches('-').length;
    return name.substring(0, to) + mods[cs].replaceAll('-', '');
  }

  String _checkException(String name, int cs, String type) {
    if (!_rules[type].keys.contains('exceptions')) {
      return null;
    }

    final lowerName = name.toLowerCase();

    for (var rule in _rules[type]['exceptions']) {
      if (!_checkGender(rule['gender'])) {
        continue;
      }

      if (rule['test'].contains(lowerName)) {
        if (rule['mods'][cs] == '.') {
          return name;
        }

        return _applyRule(rule['mods'], name, cs);
      }
    }

    return null;
  }

  String _findInRules(String name, int cs, String type) {
    final suffixes = _rules[type]['suffixes'];

    for (var rule in suffixes) {
      if (!_checkGender(rule['gender'])) {
        continue;
      }

      for (String lastChar in rule['test']) {
        final from = name.length - lastChar.length;
        final lastNameChar = name.substring(from, name.length);

        if (lastChar == lastNameChar) {
          if (rule['mods'][cs] == '.') {
            return name;
          }

          return _applyRule(rule['mods'], name, cs);
        }
      }
    }

    return name;
  }

  String _inflect(String name, int cs, String type) {
    final namesArr = name.split('-');
    final result = <String>[];

    namesArr.forEach((String arrName) {
      final exception = _checkException(arrName, cs, type);
      if (exception is String) {
        result.add(exception);
      } else {
        result.add(_findInRules(name, cs, type));
      }
    });

    return result.join('-');
  }

  String lastName(String name, [int cs = CASE_NOMENATIVE]) {
    if (cs == CASE_NOMENATIVE) {
      return name;
    }

    return _inflect(name, cs, 'lastname');
  }

  String middleName(String name, [int cs = CASE_NOMENATIVE]) {
    if (cs == CASE_NOMENATIVE) {
      return name;
    }

    return _inflect(name, cs, 'middlename');
  }

  String firstName(String name, [int cs = CASE_NOMENATIVE]) {
    if (cs == CASE_NOMENATIVE) {
      return name;
    }

    return _inflect(name, cs, 'firstname');
  }
}
