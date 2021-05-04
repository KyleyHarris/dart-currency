import 'package:currency/currency.dart';
import 'package:test/test.dart';

void main() {
  group('A group of Currency tests', () {
    setUp(() {});

    test('construction', () {
      var money = Currency(0);
      String moneyStr;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '0.0000', isTrue);

      money = Currency('123.45');
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4500', isTrue);

      money = Currency('123.45678');
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4568', isTrue);

      money = Currency(123.45);
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4500', isTrue);

      money = Currency(123.45678);
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4568', isTrue);
      expect(money.toStringAsFixed(2) == '123.46', isTrue);
    });

    test('addition', () {
      var money = Currency(0);
      money += 23;
      money += '5.67899';
      String moneyStr;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '28.6790', isTrue);

      money += 4.003567;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '32.6826', isTrue);
    });
    test('assignment', () {
      var money = Currency(0);
      money.value = 23.67999;
      String moneyStr;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '23.6800', isTrue);
    });
  });
}
