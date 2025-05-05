import 'package:flutter_test/flutter_test.dart';
import 'package:binance_mobile/main.dart';

void main() {
  testWidgets('Test ứng dụng BINANCE', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
