import 'package:currency/currency.dart';

void main() {
/*
replicates money type in ms-sql as a 4dp accurate currency type
declare @m as money
set @m = 12.45
set @m = @m + '3.00456'
set @m = @m + 38.00089
select @m  -- 53.4555
*/

  var value = Currency(12.45);
  print(value); // 12.4500
  value += Currency('3.00456');
  print(value); // 15.4546
  value += 38.00089;
  print(value); // 53.4555
  print(value.toStringAsFixed(2));

  print(Currency(0) + '123.456' + 789.023); //912.4790
}
