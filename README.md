A Currency Library to replicate functionality of the ms-sql money type, and Delphi Currency type
which is a numeric type accurate and rounded to 4dp. All Equivalences are converted to Currency first before
evaluation. All operations are done first, then converted.

## Usage

A simple usage example:

```dart
import 'package:sql_money/sql_money.dart';

main() {
  var value = Currency(12.45);
  print(value); // 12.4500
  value += Currency('3.00456');
  print(value); // 15.4546
  value += 38.00089;
  print(value); // 53.4555
  print(value.toStringAsFixed(2));

  print(Currency(0) + '123.456' + 789.023); //912.4790
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/KyleyHarris/dart-currency/issues
