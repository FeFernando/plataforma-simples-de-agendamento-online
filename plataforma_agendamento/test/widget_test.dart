
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_agendamento/main.dart';

void main() {
  testWidgets('Exibe a tela principal de agendamento', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Agende seu horário'), findsOneWidget);
    expect(find.text('Seus dados'), findsOneWidget);
    expect(find.text('Escolha um horário'), findsOneWidget);
  });
}
