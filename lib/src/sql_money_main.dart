import 'dart:math';

/// a 4dp accurate numeric type for currency operations
///
/// this class is equivalent to the ms-sql datatype money
/// and also the same as Delphi type Currency.
/// all values are stored as a big in with a 4dp multiplier
/// and kept accurate to 4dp suitable for financial application
/// SqlMoney can accept all num types and strings containing numbers
class SqlMoney implements Comparable<SqlMoney> {
  static final int _sqlMoneyDecimalPlaces = 4;
  static final String _wholeNumEnding =
      '.'.padRight(_sqlMoneyDecimalPlaces + 1, '0');
  static final BigInt _multiplier =
      BigInt.from(1 * pow(10, _sqlMoneyDecimalPlaces));
  BigInt _value = BigInt.from(0);

  SqlMoney([Object? v]) {
    if (v != null && v is String) {
      value = double.parse(v);
    } else if (v != null && v is num) {
      value = v * 1.0;
    }
  }

  ///get the value of the money as a double
  double get value => (_value / _multiplier);

  ///set the internal value of the money as a double.
  set value(double newValue) {
    _value = BigInt.from((newValue * _multiplier.toInt()).round());
  }

  @override
  int compareTo(SqlMoney other) {
    return _value.compareTo(other._value);
  }

  static int compare(Comparable a, Comparable b) => a.compareTo(b);

  @override
  int get hashCode => _value.hashCode;

  static SqlMoney? tryParse(String value) {
    var v = double.tryParse(value);
    if (v != null) {
      return SqlMoney(v);
    } else {
      return null;
    }
  }

  static SqlMoney parseWithDefault(String value, SqlMoney defaultValue) {
    var v = double.tryParse(value);
    if (v != null) {
      return SqlMoney(v);
    } else {
      return defaultValue;
    }
  }

  @override
  String toString() {
    var s = _value.toString().padRight(5, '0');
    return s.substring(0, s.length - 4) + '.' + s.substring(s.length - 4);
  }

  String toStringAsFixed(int fractionDigits) =>
      value.toStringAsFixed(fractionDigits);

  String toString2Dp() => toStringAsFixed(2);

  ///return the shortest possible string for the value
  ///eg
  ///1.2500 => "1.25"
  ///1.0000 => "1"
  String toStringNoPadding() {
    var s = toString();
    if (s.endsWith(_wholeNumEnding)) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  SqlMoney operator +(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value + other.value);
    } else if (other is num) {
      return SqlMoney(value + other);
    } else if (other is String) {
      return SqlMoney(value + double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator -(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value - other.value);
    } else if (other is num) {
      return SqlMoney(value - other);
    } else if (other is String) {
      return SqlMoney(value - double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator *(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value * other.value);
    } else if (other is num) {
      return SqlMoney(value * other);
    } else if (other is String) {
      return SqlMoney(value * double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator %(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value % other.value);
    } else if (other is num) {
      return SqlMoney(value % other);
    } else if (other is String) {
      return SqlMoney(value % double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator /(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value / other.value);
    } else if (other is num) {
      return SqlMoney(value / other);
    } else if (other is String) {
      return SqlMoney(value / double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator ~/(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value ~/ other.value);
    } else if (other is num) {
      return SqlMoney(value ~/ other);
    } else if (other is String) {
      return SqlMoney(value ~/ double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney operator -() => SqlMoney(-value);

  /// Return the remainder from dividing this [num] by [other].
  SqlMoney remainder(Object other) {
    if (other is SqlMoney) {
      return SqlMoney(value.remainder(other.value));
    } else if (other is num) {
      return SqlMoney(value.remainder(other));
    } else if (other is String) {
      return SqlMoney(value.remainder(double.parse(other.toString())));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational less than operator.
  bool operator <(Object other) {
    if (other is SqlMoney) {
      return value < other.value;
    } else if (other is num) {
      return value < SqlMoney(other).value;
    } else if (other is String) {
      return value < SqlMoney(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  @override
  bool operator ==(Object other) {
    if (other is SqlMoney) {
      return value == other.value;
    } else if (other is double) {
      return value == SqlMoney(other).value;
    } else if (other is int) {
      return value == SqlMoney(other).value;
    } else if (other is String) {
      return value == SqlMoney(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational less than or equal operator.
  bool operator <=(Object other) {
    if (other is SqlMoney) {
      return value <= other.value;
    } else if (other is double) {
      return value <= SqlMoney(other).value;
    } else if (other is int) {
      return value <= SqlMoney(other).value;
    } else if (other is String) {
      return value <= SqlMoney(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational greater than operator.
  bool operator >(Object other) {
    if (other is SqlMoney) {
      return value > other.value;
    } else if (other is double) {
      return value > SqlMoney(other).value;
    } else if (other is int) {
      return value > SqlMoney(other).value;
    } else if (other is String) {
      return value > SqlMoney(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational greater than or equal operator.
  bool operator >=(Object other) {
    if (other is SqlMoney) {
      return value >= other.value;
    } else if (other is double) {
      return value >= SqlMoney(other).value;
    } else if (other is int) {
      return value >= SqlMoney(other).value;
    } else if (other is String) {
      return value >= SqlMoney(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  SqlMoney abs() => SqlMoney(value.abs());

  /// Returns the greatest integer value no greater than this [num].
  SqlMoney floor() => SqlMoney(value.floor());

  /// Returns the least integer value that is no smaller than this [num].
  SqlMoney ceil() => SqlMoney(value.ceil());

  /// Returns the integer value closest to this [num].
  ///
  /// Rounds away from zero when there is no closest integer:
  /// [:(3.5).round() == 4:] and [:(-3.5).round() == -4:].
  SqlMoney round() => SqlMoney(value.round());

  /// Returns the integer value obtained by discarding any fractional digits
  /// from this [num].
  SqlMoney truncate() => SqlMoney(value.truncate());

  /// Returns the integer value closest to `this`.
  ///
  /// Rounds away from zero when there is no closest integer:
  /// [:(3.5).round() == 4:] and [:(-3.5).round() == -4:].
  ///
  /// The result is a double.
  double roundToDouble() => value.roundToDouble();

  /// Returns the greatest integer value no greater than `this`.
  ///
  /// The result is a double.
  double floorToDouble() => value.floorToDouble();

  /// Returns the least integer value no smaller than `this`.
  ///
  /// The result is a double.
  double ceilToDouble() => value.ceilToDouble();
}
