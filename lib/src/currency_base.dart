import 'dart:math';

final int currencyDecimalPlaces = 4;

/// a 4dp accurate numeric type for currency operations
///
/// this class is equivalent to the ms-sql datatype money
/// and also the same as Delphi type Currency.
/// all values are stored as a big in with a 4dp multiplier
/// and kept accurate to 4dp suitable for financial application
/// Currency can accept all num types and strings containing numbers
class Currency implements Comparable<Currency> {
  final BigInt _multiplier = BigInt.from(1 * pow(10, currencyDecimalPlaces));
  BigInt _value = BigInt.from(0);

  Currency([Object? v]) {
    if (v != null && v is String) {
      value = double.parse(v);
    } else if (v != null && v is num) {
      value = v * 1.0;
    }
  }

  ///get the value of the currency as a double
  double get value => (_value / _multiplier);

  ///set the internal value of the currency as a double.
  set value(double newValue) {
    _value = BigInt.from((newValue * _multiplier.toInt()).round());
  }

  @override
  int compareTo(Currency other) {
    return _value.compareTo(other._value);
  }

  static int compare(Comparable a, Comparable b) => a.compareTo(b);

  @override
  int get hashCode => _value.hashCode;

  static Currency? tryParse(String value) {
    var v = double.tryParse(value);
    if (v != null) {
      return Currency(v);
    } else {
      return null;
    }
  }

  static Currency parseWithDefault(String value, Currency defaultValue) {
    var v = double.tryParse(value);
    if (v != null) {
      return Currency(v);
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

  Currency operator +(Object other) {
    if (other is Currency) {
      return Currency(value + other.value);
    } else if (other is num) {
      return Currency(value + other);
    } else if (other is String) {
      return Currency(value + double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator -(Object other) {
    if (other is Currency) {
      return Currency(value - other.value);
    } else if (other is num) {
      return Currency(value - other);
    } else if (other is String) {
      return Currency(value - double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator *(Object other) {
    if (other is Currency) {
      return Currency(value * other.value);
    } else if (other is num) {
      return Currency(value * other);
    } else if (other is String) {
      return Currency(value * double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator %(Object other) {
    if (other is Currency) {
      return Currency(value % other.value);
    } else if (other is num) {
      return Currency(value % other);
    } else if (other is String) {
      return Currency(value % double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator /(Object other) {
    if (other is Currency) {
      return Currency(value / other.value);
    } else if (other is num) {
      return Currency(value / other);
    } else if (other is String) {
      return Currency(value / double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator ~/(Object other) {
    if (other is Currency) {
      return Currency(value ~/ other.value);
    } else if (other is num) {
      return Currency(value ~/ other);
    } else if (other is String) {
      return Currency(value ~/ double.parse(other.toString()));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency operator -() => Currency(-value);

  /// Return the remainder from dividing this [num] by [other].
  Currency remainder(Object other) {
    if (other is Currency) {
      return Currency(value.remainder(other.value));
    } else if (other is num) {
      return Currency(value.remainder(other));
    } else if (other is String) {
      return Currency(value.remainder(double.parse(other.toString())));
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational less than operator.
  bool operator <(Object other) {
    if (other is Currency) {
      return value < other.value;
    } else if (other is num) {
      return value < Currency(other).value;
    } else if (other is String) {
      return value < Currency(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  @override
  bool operator ==(Object other) {
    if (other is Currency) {
      return value == other.value;
    } else if (other is double) {
      return value == Currency(other).value;
    } else if (other is int) {
      return value == Currency(other).value;
    } else if (other is String) {
      return value == Currency(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational less than or equal operator.
  bool operator <=(Object other) {
    if (other is Currency) {
      return value <= other.value;
    } else if (other is double) {
      return value <= Currency(other).value;
    } else if (other is int) {
      return value <= Currency(other).value;
    } else if (other is String) {
      return value <= Currency(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational greater than operator.
  bool operator >(Object other) {
    if (other is Currency) {
      return value > other.value;
    } else if (other is double) {
      return value > Currency(other).value;
    } else if (other is int) {
      return value > Currency(other).value;
    } else if (other is String) {
      return value > Currency(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  /// Relational greater than or equal operator.
  bool operator >=(Object other) {
    if (other is Currency) {
      return value >= other.value;
    } else if (other is double) {
      return value >= Currency(other).value;
    } else if (other is int) {
      return value >= Currency(other).value;
    } else if (other is String) {
      return value >= Currency(other.toString()).value;
    }
    throw ArgumentError(other.toString() + 'is not a number');
  }

  Currency abs() => Currency(value.abs());

  /// Returns the greatest integer value no greater than this [num].
  Currency floor() => Currency(value.floor());

  /// Returns the least integer value that is no smaller than this [num].
  Currency ceil() => Currency(value.ceil());

  /// Returns the integer value closest to this [num].
  ///
  /// Rounds away from zero when there is no closest integer:
  /// [:(3.5).round() == 4:] and [:(-3.5).round() == -4:].
  Currency round() => Currency(value.round());

  /// Returns the integer value obtained by discarding any fractional digits
  /// from this [num].
  Currency truncate() => Currency(value.truncate());

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
