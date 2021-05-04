import 'package:sql_money/sql_money.dart';
import 'package:test/test.dart';

void main() {
  group('A group of SqlMoney tests', () {
    setUp(() {});

    test('construction', () {
      var money = SqlMoney(0);
      String moneyStr;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '0.0000', isTrue);

      money = SqlMoney('123.45');
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4500', isTrue);

      money = SqlMoney('123.45678');
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4568', isTrue);

      money = SqlMoney(123.45);
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4500', isTrue);

      money = SqlMoney(123.45678);
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '123.4568', isTrue);
      expect(money.toStringAsFixed(2) == '123.46', isTrue);
    });

    test('addition', () {
      var money = SqlMoney(0);
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
      var money = SqlMoney(0);
      money.value = 23.67999;
      String moneyStr;
      moneyStr = money.toString();
      print(moneyStr);
      expect(moneyStr == '23.6800', isTrue);
    });

    test('strings', () {
      expect(SqlMoney(1.256).toString2Dp() == '1.26', isTrue);
      expect(SqlMoney(1.25).toString2Dp() == '1.25', isTrue);
      expect(SqlMoney(11.0).toString2Dp() == '11.00', isTrue);
      expect(SqlMoney(3).toString2Dp() == '3.00', isTrue);
      expect(SqlMoney(11.0).toStringNoPadding() == '11', isTrue);
      expect(SqlMoney(3).toStringNoPadding() == '3', isTrue);
      expect(SqlMoney(11.12).toStringNoPadding() == '11.12', isTrue);
      expect(SqlMoney(3.123).toStringNoPadding() == '3.123', isTrue);
    });
  });
}
